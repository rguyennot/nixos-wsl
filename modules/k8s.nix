{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kubectl                   # k8s cli
    kubectl-cnpg              # k8s plugin for CNPG operator
    kubectl-view-secret       # k8s plugin to view secrets in a human readable format
    kubectl-neat              # k8s plugin to clean up YAML output
    kubectl-klock             # k8s plugin to render watch output in a more readable fashion
    kubectl-df-pv             # k8s plugin to display PV disk usage
    krew                      # k8s cli plugin manager
    k9s                       # k8s TUI browser
    kubectx                   # k8s contexts switcher
    kubecm                    # k8S contexts manager
    kubecolor                 # k8s output colorizer
    kubelogin-oidc            # OIDC auth provider for kubectl
    kustomize                 # Tool for customizing Kubernetes YAML configurations
    kubernetes-helm           # Package manager for kubernetes
    cmctl                     # Command line tool for managing Cert-Manager
    cilium-cli                # CLI to install, manage & troubleshoot Kubernetes clusters running Cilium
    hubble                    # CLI to troubleshoot Cilium network issues
    stern                     # Multi pod and container log tailing for Kubernetes
    velero                    # Backup and restore tool (kopia) for Kubernetes clusters
    terraform                 # Infrastructure as Code tool, often used for managing Kubernetes infrastructure  
  ];
}
