FactoryGirl.define do
  factory :list_item do
    list       { create(:wants) }
    product    { create(:product) }
    created_by { list.owner.id }
  end
end
