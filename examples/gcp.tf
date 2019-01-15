provider "google" {
  credentials = "${file("~/.config/gcloud/terraform-service-account.json")}"
  region      = "us-central1"
}

provider "google-beta" {
  credentials = "${file("~/.config/gcloud/terraform-service-account.json")}"
  region      = "us-central1"
}
