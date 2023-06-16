module "helm3_unittest" {
  source = "github.com/bjw-s/terraform-github-repository?ref=v1.1.0"

  name        = "helm3-unittest"
  description = "Fork of lrills/helm-unittest but for Helm 3"
  topics      = ["helm", "unittest", "golang"]
  visibility  = "public"

  auto_init              = true
  allow_merge_commit     = false
  allow_squash_merge     = true
  allow_auto_merge       = true
  delete_branch_on_merge = true

  has_issues   = true
  has_wiki     = false
  has_projects = false

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
}
