module "cf_domain_family" {
  source     = "./modules/cf_domain"
  domain     = local.domains["family"]
  account_id = cloudflare_account.bjw_s.id
}
