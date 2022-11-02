output "ingress_namespace" {
  description = "The Ingress Namespace"
  value       = local.helm_config["namespace"]
}

output "ingress_name" {
  description = "The Ingress Name"
  value       = local.helm_config["name"]
}

output "argocd_gitops_config" {
  description = "Configuration used for managing the add-on with ArgoCD"
  value       = var.manage_via_gitops ? local.argocd_gitops_config : null
}
