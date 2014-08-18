FactoryGirl.define do
  factory :list_item do
    list       { create(:wants) }
    product    { create(:product) }

    before(:create) do |list_item|
      list_item.creator = list_item.list.owner
    end
  end
end
