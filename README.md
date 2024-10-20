
# 🚀 cookiecutter-terragrunt-project

A Cookiecutter template designed to effortlessly create Terragrunt-based infrastructure projects. With this template, you can set up scalable, multi-environment cloud infrastructure following best practices, all while saving time and ensuring consistency across your deployments. 🌍

## 🎯 Features

- 🌍 **Multi-environment Support**: Quickly set up different environments (e.g., dev, staging, production) using Terragrunt.
- 💡 **DRY Terraform Configurations**: Utilize Terragrunt's capabilities to keep your Terraform code DRY and maintainable.
- 🛠️ **Customizable**: Easily customize the generated structure to fit your team's requirements.

## 📚 Getting Started

1. **Prerequisites**:
   - Python 3.6+ 🐍
   - [Cookiecutter](https://cookiecutter.readthedocs.io/en/latest/installation.html) installed 🍪
   - [Terragrunt](https://terragrunt.gruntwork.io) and [Terraform](https://www.terraform.io) installed 🌱

2. **Installation**:

   Install Cookiecutter if you haven't already:

   ```sh
   pip install cookiecutter
   ```

3. **Generate a new Terragrunt project**:

   ```sh
   cookiecutter https://github.com/your-org/cookiecutter-terragrunt-project.git
   ```

4. **Follow the prompts** to configure your project (e.g., project name, environments) 📝.

## 📁 Project Structure

The generated project will have a structure similar to:

```
.
├── google
│   └── terragrunt.hcl
└── README.md
```

## 🎉 Why Choose cookiecutter-terragrunt-project?

- 🛠️ **Developer-Friendly**: Designed with simplicity and productivity in mind, allowing developers to focus on infrastructure rather than setup.
- 🔄 **Multi-environment Workflows**: Quickly set up, configure, and manage multiple environments with ease.

## 🤝 Contributing

We welcome contributions from the community! 🌍

1. Fork the repo
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a pull request

## 📄 License

This project is licensed under the MIT License 📜. See the [LICENSE](LICENSE) file for details.

## ✨ Acknowledgements

Thanks to all the developers and contributors who make `cookiecutter-terragrunt-project` possible. Let's build great infrastructure together! ⚓

---

Enjoy using `cookiecutter-terragrunt-project` to streamline your infrastructure projects! 🎊