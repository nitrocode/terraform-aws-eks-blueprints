locals {
  name                 = "falco"
  service_account_name = "${local.name}-sa"

  # https://github.com/falcosecurity/charts/blob/HEAD/falco/Chart.yaml
  default_helm_config = {
    name        = local.name
    chart       = local.name
    repository  = "https://falcosecurity.github.io/charts"
    version     = "2.2.0"
    namespace   = "kube-system"
    values      = local.default_helm_values
    description = "${local.name} Helm Chart for ingress resources"
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  default_helm_values = [file("${path.module}/values.yaml")]

  set_values = concat(
    [
      {
        name  = "serviceAccount.name"
        value = local.service_account_name
      },
      {
        name  = "serviceAccount.create"
        value = false
      }
    ],
    try(var.helm_config.set_values, [])
  )

  argocd_gitops_config = {
    enable             = true
    serviceAccountName = local.service_account_name
  }

  irsa_config = {
    kubernetes_namespace              = local.helm_config["namespace"]
    kubernetes_service_account        = local.service_account_name
    create_kubernetes_namespace       = try(local.helm_config["create_namespace"], true)
    create_kubernetes_service_account = true
    irsa_iam_policies                 = [aws_iam_policy.default.arn]
  }
}
