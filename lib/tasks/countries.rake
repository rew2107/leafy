namespace :countries do
  desc "seed the countries"
  task :seed => :environment do
    Country.destroy_all

    Country.create(:id => 1, :name => 'United States', :flag => 'USA')
    Country.create(:id => 2, :name => 'Australia', :flag => 'Australia')
    Country.create(:id => 3, :name => 'South Korea', :flag => 'SouthKorea')
    Country.create(:id => 4, :name => 'Britian', :flag => 'UK')
    Country.create(:id => 5, :name => 'Japan', :flag => 'Japan')
    Country.create(:id => 6, :name => 'France', :flag => 'France')
  end
end
