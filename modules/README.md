# Modules

This directory is reserved for reusable **child modules** that encapsulate
specific pieces of infrastructure.

## Structure Convention

```
modules/
└── <module-name>/
    ├── main.tf        # Resource definitions
    ├── variables.tf   # Input variables
    ├── outputs.tf     # Output values
    └── README.md      # Module documentation
```

## Usage

Call a child module from the root module:

```hcl
module "example" {
  source = "./modules/<module-name>"

  some_variable = var.some_variable
}
```

See the [Terraform Modules documentation](https://developer.hashicorp.com/terraform/language/modules) for guidance.
