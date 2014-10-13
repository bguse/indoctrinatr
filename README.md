# ![Indoctrinatr](app/assets/images/logo.png)

## About

Indoctrinatr is an Open Source Software project by [dkd Internet Service GmbH](https://dkd.de/), Frankfurt (Germany), which renders [eRuby](https://en.wikipedia.org/wiki/ERuby) (more specifically: [Erubis](http://www.kuwata-lab.com/erubis/)) enriched [XeTex](http://tug.org/xetex/) templates to PDF documents.

## Setup (development environment)

1.  Install XeTex:

    Mac OS X: [MacTex](https://tug.org/mactex/)
 
    Debian/Ubuntu: `apt-get install texlive-full`

2.  Use Ruby (v2.0 or later):

    We recommend installation via [Ruby Version Manager](https://rvm.io/), [rbenv](http://rbenv.org/) or [Brightbox Ruby NG](http://brightbox.com/docs/ruby/ubuntu/).

3.  Clone this repository:

    ```Shell
    git clone blargh
    ```

4.  Run [Bundler](http://bundler.io/) inside your local repository to install project dependencies:

    ```Shell
    bundle install
    ```

5.  Setup database and import Indoctrinatr Achievement Template Pack®:

    ```Shell
    rake db:setup
    ```

6.  Start application server:

    ```Shell
    rails server
    ```

7.  Direct your preferred browser to <http://127.0.0.1:3000/>.

## Usage

### XeTex Templates with ERB

#### About

Indoctrinatr allows you to define XeTex templates mixed with template fields via ERB. User can then enter values for these template fields and Indoctrinatr will render the template together with these user supplied values. Just write your XeTeX template like you normally would, enter it into the web interface, define template fields as needed and insert them like `<%= template_field_name %>` into your template (also see [Jason Shultz](http://jasonshultz.com/2013228examples-of-ruby-erb-syntax/) or [Stack Overflow](http://stackoverflow.com/questions/7996695/what-is-the-difference-between-and-in-erb-in-rails) for ERB syntax). The name of the template field corresponds to the name of the variable you can access in your template.

#### Sample

    % This is the official Indoctrinatr "Hello World Template".
    \documentclass{article}

    \begin{document}
             \section{Hello <%= variable1 -%>}
             
             The <%= variable1 -%> is <%= variable2 -%>!
    \end{document}

This Hello World example has two template fields: `variable1` and `variable2`. See below for their respective definition via Indoctrinatr Template Pack.

#### Typecasting (sort of)

Please note: The values of the template fields are LaTeX safe strings (Ruby class: [LatexString](http://rubydoc.info/gems/to_latex/0.5.0/)) by default. If you want to process these values we suggest you convert them to native Ruby values like `Integer(template_field_variable)`. This allows you to iterate over a user supplied value for example:

    <% Integer(counter).times do |count| %>
      <%= count %>
    <% end %>

#### Textile Support

If you want to convert (user supplied) values formatted in [Textile](http://txstyle.org/) to XeTeX wrap the variable name as follows:

    <%= textilize(template_field_name) %>

### Indoctrinatr Template Packs

#### About

Beside creating templates via web interface there is another way: Template Packs are zipped XeTex templates with configuration and asset files (images, PDF documents and the like) which can be uploaded and imported into Indoctrinatr. They can be easily created with Indoctrinatr Tools (see below).

#### Configuration Syntax

##### API

The file `configuration.yaml` contains all relevant information (in [YAML](http://www.yaml.org/)) about this Template Pack.

| name | validity | description |
|----|----|----|
| `template_name` | required | Short name for your template. |
| `fields` | optional | List of template fields you want to use with your template. Empty list if not specified. |

For each field you need to specify:

| name | validity | description |
|----|----|----|
| `name` | required | Short name for this field. |
| `presentation` | required | Choose from this list of valid presentation values (with respect to their respective HTML equivalent for this field): `text`, `textarea`, `checkbox`, `radiobutton`, `dropdown`, `date`, `range` |
| `default_value` | optional | Default value for this field, which will be used if no value is supplied by the user. Empty string if not specified. |
| `available_options` | required (for `presentation` of `checkbox`, `radiobutton` or `dropdown`) | List of selectable text options, entries separated by commata. |
| `start_of_range` | required (for `presentation` of `range`) | Value of lower bound for this range selector. |
| `end_of_range` | required for (`presentation` of `range`) | Value of upper bound for this range selector. |

##### Sample

```YAML
    template_name: Hello World Template
    fields:
      -
        name: variable1
        presentation: text
        default_value: World
      -
        name: variable2
        presentation: dropdown
        default_value: not enough
        available_options: not enough, beautiful, your oyster, a template
```

#### Assets

Place your assets (e.g. images, PDF documents) into the `assets` folder. If you want to reference this folder inside your XeTex template please use the variable `template_asset_path` like this: `<%= template_asset_path -%>`. It will be resolve correctly on you machine locally as well as on the server. 

### Indoctrinatr Tools

[Indoctrinatr Tools](__TODO__) is a set of commandline tools to kick-start and develop Indoctrinatr Template Packs. Install via `gem install indoctrinatr-tools`. Note: You need to have XeTex installed locally to use Indoctrinatr Tools if you are running Indoctrinatr on a different machine (e.g. server setup).

Run `indoctrinatr help` to see a list of available commands. `indoctrinatr workflow` describes the general approach to developing templates. Run `indoctrinatr demo` to see a minimalistic working project sample.

Protip: Use `indoctrinatr bashcompletion` or `indoctrinatr zshcompletion` to save precious time and energy.

## Feedback

What you think of Indoctrinatr? Drop us a [line](info@dkd.de) and tell us how you use Indoctrinatr. You can also open an issue if you experience any problems.

## Contributing

We are also looking forward to your [GitHub Pull Requests](https://help.github.com/articles/using-pull-requests/).

## License

Indoctrinatr is licensed under the terms and conditions of [__TODO__]().

## Credits

[![dkd](app/assets/images/dkd_logo.png)](https://dkd.de/)

* Valeria Krasteva (design)
* Wilfried Irßlinger (frontend development)
* Nicolai Reuschling (backend development)
* Søren Schaffstein (idea, product management)
* Stefan Sprenger (development of an earlier version)