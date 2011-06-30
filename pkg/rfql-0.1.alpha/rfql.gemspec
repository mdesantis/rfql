# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rfql}
  s.version = "0.1.alpha"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{De Santis Maurizio}]
  s.cert_chain = [%q{/home/mau/.gem_keys/gem-public_cert.pem}]
  s.date = %q{2011-06-30}
  s.description = %q{RFQL - Ruby interface for Facebook Query Language}
  s.email = %q{desantis.maurizio@gmail.com}
  s.extra_rdoc_files = [%q{CHANGELOG}, %q{LICENSE}, %q{README.rdoc}, %q{lib/rfql.rb}, %q{lib/rfql/core_ext/object/blank.rb}, %q{lib/rfql/query.rb}, %q{lib/rfql/query/methods.rb}, %q{lib/rfql/query/quoting.rb}, %q{lib/rfql/request.rb}, %q{lib/rfql/request/delegations.rb}, %q{lib/rfql/response.rb}, %q{lib/rfql/response/fql_error.rb}, %q{lib/rfql/response/json.rb}, %q{lib/rfql/response/json/parsed.rb}, %q{lib/rfql/response/json/parsed/error.rb}, %q{lib/rfql/response/json/parsed/null.rb}, %q{lib/rfql/response/json/parsed/records.rb}, %q{lib/rfql/response/json/raw.rb}]
  s.files = [%q{CHANGELOG}, %q{LICENSE}, %q{Manifest}, %q{README.rdoc}, %q{Rakefile}, %q{lib/rfql.rb}, %q{lib/rfql/core_ext/object/blank.rb}, %q{lib/rfql/query.rb}, %q{lib/rfql/query/methods.rb}, %q{lib/rfql/query/quoting.rb}, %q{lib/rfql/request.rb}, %q{lib/rfql/request/delegations.rb}, %q{lib/rfql/response.rb}, %q{lib/rfql/response/fql_error.rb}, %q{lib/rfql/response/json.rb}, %q{lib/rfql/response/json/parsed.rb}, %q{lib/rfql/response/json/parsed/error.rb}, %q{lib/rfql/response/json/parsed/null.rb}, %q{lib/rfql/response/json/parsed/records.rb}, %q{lib/rfql/response/json/raw.rb}, %q{rfql.gemspec}]
  s.homepage = %q{http://http://github.com/ProGNOMmers/rfql.github.com/http://github.com/ProGNOMmers/rfql/rfql/}
  s.rdoc_options = [%q{--line-numbers}, %q{--inline-source}, %q{--title}, %q{Rfql}, %q{--main}, %q{README.rdoc}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{http://github.com/ProGNOMmers/rfql}
  s.rubygems_version = %q{1.8.5}
  s.signing_key = %q{/home/mau/.gem_keys/gem-private_key.pem}
  s.summary = %q{It lets you use ORM-style code for fetching data  from Facebook through the Facebook Query Language}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
