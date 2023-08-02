module "helm_charts" {
  source = "github.com/bjw-s/terraform-github-repository?ref=v1.2.0"

  name         = "helm-charts"
  description  = "A collection of Helm charts"
  topics       = ["helm", "kubernetes"]
  homepage_url = "https://bjw-s.github.io/helm-charts/"
  visibility   = "public"

  auto_init              = var.defaults.auto_init
  allow_merge_commit     = var.defaults.allow_merge_commit
  allow_squash_merge     = var.defaults.allow_squash_merge
  allow_auto_merge       = var.defaults.allow_auto_merge
  delete_branch_on_merge = var.defaults.delete_branch_on_merge

  squash_merge_commit_message = var.defaults.squash_merge_commit_message

  has_issues   = var.defaults.has_issues
  has_wiki     = var.defaults.has_wiki
  has_projects = var.defaults.has_projects

  plaintext_secrets = merge(
    {},
    local.bjws_bot_secrets
  )

  issue_labels_manage_default_github_labels = false
  issue_labels = concat(
    [],
    local.issue_labels_semver,
    local.issue_labels_size,
    local.issue_labels_category
  )

  branches = [
    {
      name          = "development"
      source_branch = "main"
    },
    {
      name = "gh-pages"
    }
  ]

  collaborators = [
    {
      username   = "onedr0p"
      permission = "push"
    }
  ]

  pages = {
    build_type = "legacy"
    branch     = "gh-pages"
    path       = "/"
  }
}
