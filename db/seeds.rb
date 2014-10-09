def create_category(parent, name, color = nil)
  if parent
    parent.children.create(name: name)
  else
    Category.create(
      name: name,
      color: color
    )
  end
end

men = Category.create(
  name: 'Men\'s',
  color: '#FF4136'
)

  men_clothing = men.children.create(name: 'Clothing')
    men_clothing_tops = men_clothing.children.create(name: 'Tops')
      men_clothing_tops.children.create(name: 'Shirts')
      men_clothing_tops.children.create(name: 'Sweaters')
      men_clothing_tops.children.create(name: 'Sweatshirts')
      men_clothing_tops.children.create(name: 'Tees')
    men_clothing_bottoms = men_clothing.children.create(name: 'Bottoms')
      men_clothing_bottoms.children.create(name: 'Jeans')
      men_clothing_bottoms.children.create(name: 'Pants')
      men_clothing_bottoms.children.create(name: 'Shorts')
      men_clothing_bottoms.children.create(name: 'Socks')
      men_clothing_bottoms.children.create(name: 'Underwear')
      men_clothing_bottoms.children.create(name: 'Swim')
    men_clothing_outerwear = men_clothing.children.create(name: 'Outerwear')
    men_clothing_suits = men_clothing.children.create(name: 'Suits')

  men_shoes = men.children.create(name: 'Shoes')
    men_shoes.children.create(name: 'Casual')
    men_shoes.children.create(name: 'Sneakers')
    men_shoes.children.create(name: 'Dress')
    men_shoes.children.create(name: 'Boots')
    men_shoes.children.create(name: 'Sandals')

  men_accessories = men.children.create(name: 'Accessories')
    men_bags = men_accessories.children.create(name: 'Bags')
      men_bags.children.create(name: 'Backpacks')
      men_bags.children.create(name: 'Messenger')
      men_bags.children.create(name: 'Luggage')
    men_watches = men_accessories.children.create(name: 'Watches')
      men_watches.children.create(name: 'Casual')
      men_watches.children.create(name: 'Formal')
    men_accessories.children.create(name: 'Wallets')
    men_accessories.children.create(name: 'Belts')
    men_accessories.children.create(name: 'Ties')
    men_hats = men_accessories.children.create(name: 'Wallets')
      men_hats.children.create(name: 'Caps')
      men_hats.children.create(name: 'Classic')
      men_hats.children.create(name: 'Beanies')
    men_glasses = men_accessories.children.create(name: 'Glasses')
      men_glasses.children.create(name: 'Vision')
      men_glasses.children.create(name: 'Sunglasses')
    men_accessories.children.create(name: 'Other')

women = Category.create(
  name: 'Women\'s',
  color: '#85144B'
)
  women_clothing = women.children.create(name: 'Clothing')
    women_clothing.children.create(name: 'Dresses')
    women_tops = women_clothing.children.create(name: 'Tops')
      women_tops.children.create(name: 'Shirts')
      women_tops.children.create(name: 'Sweaters')
      women_tops.children.create(name: 'Sweatshirts')
      women_tops.children.create(name: 'Tees')
      women_tops.children.create(name: 'Blazers')
    women_bottoms = women_clothing.children.create(name: 'Bottoms')
      women_bottoms.children.create(name: 'Jeans')
      women_bottoms.children.create(name: 'Pants')
      women_bottoms.children.create(name: 'Shorts')
      women_bottoms.children.create(name: 'Rompers')
      women_bottoms.children.create(name: 'Skirts')
      women_bottoms.children.create(name: 'Swim')
    women_clothing.children.create(name: 'Outerwear')
    women_underwear = women_clothing.children.create(name: 'Underwear')
      women_underwear.children.create(name: 'Bras & Undies')
      women_underwear.children.create(name: 'Slips')
      women_underwear.children.create(name: 'Bodysuits')
      women_underwear.children.create(name: 'Tights')
      women_underwear.children.create(name: 'Socks')
  women_shoes = women.children.create(name: 'Shoes')
    women_shoes.children.create(name: 'Flats')
    women_shoes.children.create(name: 'Heels')
    women_shoes.children.create(name: 'Sneakers')
    women_shoes.children.create(name: 'Boots')
    women_shoes.children.create(name: 'Sandals')
  women_accessories = women.children.create(name: 'Accessories')
    women_bags = women_accessories.children.create(name: 'Bags')
      women_bags.children.create(name: 'Purses')
      women_bags.children.create(name: 'Totes')
      women_bags.children.create(name: 'Backpacks')
      women_bags.children.create(name: 'Luggage')
    women_watches = women_accessories.children.create(name: 'Watches')
      women_watches.children.create(name: 'Casual')
      women_watches.children.create(name: 'Formal')
    women_jewelry = women_accessories.children.create(name: 'Jewelry')
      women_jewelry.children.create(name: 'Earrings & Piercings')
      women_jewelry.children.create(name: 'Necklaces')
      women_jewelry.children.create(name: 'Bracelets')
      women_jewelry.children.create(name: 'Rings')
      women_jewelry.children.create(name: 'Other')
    women_hats = women_accessories.children.create(name: 'Hats')
      women_hats.children.create(name: 'Caps')
      women_hats.children.create(name: 'Classic')
      women_hats.children.create(name: 'Beanies')
    women_glasses = women_accessories.children.create(name: 'Glasses')
      women_glasses.children.create(name: 'Vision')
      women_glasses.children.create(name: 'Sunglasses')
    women_accessories.children.create(name: 'Other')


tech = Category.create(
  name: 'Tech',
  color: '#0074D9'
)

  audio = tech.children.create(name: 'Tech')
    audio.children.create(name: 'Turntables')
    audio.children.create(name: 'Headphones')
    audio.children.create(name: 'Speakers')
    audio.children.create(name: 'Instruments')
  cameras = tech.children.create(name: 'Cameras')
    cameras.children.create(name: 'Digtial')
    cameras.children.create(name: 'Analog')
    cameras.children.create(name: 'Accessories')
  accessories = tech.children.create(name: 'Accessories')
    accessories.children.create(name: 'Laptop')
    accessories.children.create(name: 'Phone')
    accessories.children.create(name: 'Other')


media = Category.create(name: 'Media', color: '#7FDBFF')
  media.children.create(name: 'Books & Music')
  media.children.create(name: 'Movies')


home = Category.create(name: 'Home', color: '#3D9970')
  kitchen = create_category(home, 'Kitchen')
    create_category(kitchen, 'Cookware')
    create_category(kitchen, 'Coffee & Tea')
    create_category(kitchen, 'Storage')
    create_category(kitchen, 'Cutlery')
    create_category(kitchen, 'Utensils')
    create_category(kitchen, 'Applications')
    create_category(kitchen, 'Accessories')

  create_category(home, 'Bedding')
  create_category(home, 'Bath')
  create_category(home, 'Furniture')

  decor = create_category(home, 'Décor')
    create_category(decor, 'Rugs')
    create_category(decor, 'Lighting')
    create_category(decor, 'Accessories')
    create_category(decor, 'Pillows')
    create_category(decor, 'Clocks')

art = Category.create(
  name: 'Art',
  color: '#F012BE'
)
  create_category(art, '3D')
  create_category(art, 'Posters')
  create_category(art, 'Painting')
  create_category(art, 'Photography')
  create_category(art, 'Collage')
  create_category(art, 'Supplies')


other = Category.create(
  name: 'Other',
  color: '#FFDC00'
)
  create_category(other, 'Booze')
  create_category(other, 'Cycling')
  create_category(other, 'Toys')
  create_category(other, 'Games')
  create_category(other, 'Antiques')
  create_category(other, 'Pets')
  create_category(other, 'Camping')
  create_category(other, 'Tools')
