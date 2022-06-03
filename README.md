# Terraform Extip built plugin
This repo contains pre-compiled Terraform custom plugin, which is stored locally. 


Below is the guide how to compile the plugin and add it to your own project.

# Prerequisites

[Go](https://go.dev/doc/install) v1.18.1 (to build the provider plugin)

[Terraform](https://www.terraform.io/downloads) (to use the plugin)

# How to compile the plugin and add it to your Terraform Configuration

1. Download the source code to a local directory 
 ```
 git clone https://github.com/petems/terraform-provider-extip.git
 ```
 
 2. make sure you are in the directory and compile the project :
 ```
 cd terraform-provider-extip && make build
 ```
 By default Go is saving the compiled binary to `~/go/bin/terraform-provider-extip` 
 
 3. Copy your compiled plugin to your plugin directory. The shown directory is for "darwin_arm64(M1 OS X) architecture.

 ```
 cp go/bin/terraform-provider-extip *path/to/your/working/directory*/terraform.d/plugins/registry.terraform.io/hashicorp/extip/1.0.0/darwin_arm64/
 ```
 
I will describe in details which local directories Terraform includes and how:

**By default it includes the following directories in OS X:**

`$HOME/.terraform.d/plugins, `

`~/Library/Application Support/io.terraform/plugins,`

`/Library/Application Support/io.terraform/plugins`

and if you want to keep the plugins in the current working directory, like in my case:

`terraform.d/plugins`

 **There are 2 default layouts of plugins stored locally:**
* **Packed layout**: HOSTNAME/NAMESPACE/TYPE/terraform-provider-TYPE_VERSION_TARGET.zip is the distribution zip file obtained from the provider’s origin registry.
* **Unpacked layout**: HOSTNAME/NAMESPACE/TYPE/VERSION/TARGET is a directory containing the result of extracting the provider’s distribution zip file.

In our case we have to use unpacked layout:

* **Hostname** (optional): The hostname of the Terraform registry that distributes the provider. If omitted, this defaults to registry.terraform.io, the hostname of the public Terraform Registry.
* **Namespace**: An organizational namespace within the specified registry. For the public Terraform Registry and for Terraform Cloud’s private registry, this represents the organization that publishes the provider. 
* **Type**: A short name for the platform or system the provider manages. Must be unique within a particular namespace on a particular registry host.
The type is usually the provider’s preferred local name.
* **VERSION**: It includes version, which can be 1.0.0.
* **TARGET**: Target platform, it can be `darwin_amd64`, `linux_arm`, `windows_amd64`, etc.


This is the local source path used in my project: registry.terraform.io/hashicorp/extip/1.0.0/darwin_arm64/
```
Hostname: registry.terraform.io
Namespace: hashicorp
Type: extip
Version: 1.0.0
Target: darwin_arm64 (OS X M1 arch)
```

I have used `registry.terraform.io/hashicorp`, so I don't need to specify the path in `required_providers` block. 

**If you wish to use custom path, you will have to manually specify it in [required_providers](https://www.terraform.io/language/providers/requirements#local-names) block.**

# How to use the repo
**Keep in mind that the compiled plugin is for M1 architecture, it won't work on different platforms.**

1. Clone it locally:
```
git clone https://github.com/51r/terraform-custom-plugin.git
```
2. Make sure you are in the repo directory:
```
cd terraform-custom-plugin
```
3. Initialize the Terraform:
```
terraform init
```
You should get the following message:

```
Initializing provider plugins...
- Finding latest version of hashicorp/extip...
- Installing hashicorp/extip v1.0.0...
- Installed hashicorp/extip v1.0.0 (unauthenticated)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!
```

This means that the extip plugin was loaded from the local path.

4. Execute the plan:
```
terraform apply
```
