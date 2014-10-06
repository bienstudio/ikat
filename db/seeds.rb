Category.create(
  name: 'Men\'s',
  color: '#FF4136',
  children: [
    Category.create(
      name: 'Clothing',
      children: [
        Category.create(
          name: 'Tops',
          children: [
            Category.create(name: 'Shirts'),
            Category.create(name: 'Sweaters'),
            Category.create(name: 'Sweatshirts'),
            Category.create(name: 'Tees')
          ]
        ),
        Category.create(
          name: 'Bottoms',
          children: [
            Category.create(name: 'Jeans'),
            Category.create(name: 'Pants'),
            Category.create(name: 'Shorts'),
            Category.create(name: 'Socks'),
            Category.create(name: 'Underwear'),
            Category.create(name: 'Swim')
          ]
        ),
        Category.create(
          name: 'Outerwear'
        ),
        Category.create(
          name: 'Suits'
        )
      ]
    ),
    Category.create(
      name: 'Shoes',
      children: [
        Category.create(name: 'Casual'),
        Category.create(name: 'Sneakers'),
        Category.create(name: 'Dress'),
        Category.create(name: 'Boots'),
        Category.create(name: 'Sandals')
      ]
    ),
    Category.create(
      name: 'Accessories',
      children: [
        Category.create(
          name: 'Bags',
          children: [
            Category.create(name: 'Backpacks'),
            Category.create(name: 'Messenger'),
            Category.create(name: 'Luggage')
          ]
        ),
        Category.create(
          name: 'Watches',
          children: [
            Category.create(name: 'Casual'),
            Category.create(name: 'Formal')
          ]
        ),
        Category.create(
          name: 'Wallets'
        ),
        Category.create(
          name: 'Belts'
        ),
        Category.create(
          name: 'Ties'
        ),
        Category.create(
          name: 'Hats',
          children: [
            Category.create(name: 'Caps'),
            Category.create(name: 'Classic'),
            Category.create(name: 'Beanies')
          ]
        ),
        Category.create(
          name: 'Glasses'
        )
      ]
    )
  ]
)

Category.create(
  name: 'Women\'s',
  color: '#85144B',
  children: [
    Category.create(
      name: 'Dresses',
    ),
    Category.create(
      name: 'Tops',
      children: [
        Category.create(name: 'Shirts'),
        Category.create(name: 'Sweaters'),
        Category.create(name: 'Sweatshirts'),
        Category.create(name: 'Tees'),
        Category.create(name: 'Blazers')
      ]
    ),
    Category.create(
      name: 'Bottoms',
      children: [
        Category.create(name: 'Jeans'),
        Category.create(name: 'Pants'),
        Category.create(name: 'Shorts'),
        Category.create(name: 'Rompers'),
        Category.create(name: 'Skirts'),
        Category.create(name: 'Swim')
      ]
    ),
    Category.create(
      name: 'Outerwear'
    ),
    Category.create(
      name: 'Underwear',
      children: [
        Category.create(name: 'Bras & Undies'),
        Category.create(name: 'Slips'),
        Category.create(name: 'Bodysuits'),
        Category.create(name: 'Tights'),
        Category.create(name: 'Socks')
      ]
    )
  ]
)

Category.create(
  name: 'Tech',
  color: '#0074D9',
  children: [
    Category.create(
      name: 'Audio',
      children: [
        Category.create(name: 'Turntables'),
        Category.create(name: 'Headphones'),
        Category.create(name: 'Speakers'),
        Category.create(name: 'Instruments')
      ]
    ),
    Category.create(
      name: 'Cameras',
      children: [
        Category.create(name: 'Digital'),
        Category.create(name: 'Analog'),
        Category.create(name: 'Accessories')
      ]
    ),
    Category.create(
      name: 'Accessories',
      children: [
        Category.create(name: 'Laptop'),
        Category.create(name: 'Phone'),
        Category.create(name: 'Other')
      ]
    )
  ]
)

Category.create(
  name: 'Media',
  color: '#7FDBFF',
  children: [
    Category.create(name: 'Books & Music'),
    Category.create(name: 'Movies')
  ]
)

Category.create(
  name: 'Home',
  color: '#3D9970',
  children: [
    Category.create(
      name: 'Kitchen',
      children: [
        Category.create(name: 'Cookware'),
        Category.create(name: 'Coffee & Tea'),
        Category.create(name: 'Storage'),
        Category.create(name: 'Cutlery'),
        Category.create(name: 'Utensils'),
        Category.create(name: 'Applicances'),
        Category.create(name: 'Accessories')
      ]
    ),
    Category.create(
      name: 'Bedding'
    ),
    Category.create(
      name: 'Bath'
    ),
    Category.create(
      name: 'Furniture'
    ),
    Category.create(
      name: 'Décor',
      children: [
        Category.create(name: 'Rugs'),
        Category.create(name: 'Lighting'),
        Category.create(name: 'Accessories'),
        Category.create(name: 'Pillows'),
        Category.create(name: 'Clocks')
      ]
    )
  ]
)

Category.create(
  name: 'Art',
  color: '#F012BE',
  children: [
    Category.create(name: '3D'),
    Category.create(name: 'Posters'),
    Category.create(name: 'Photography'),
    Category.create(name: 'Collage'),
    Category.create(name: 'Supplies')
  ]
)

Category.create(
  name: 'Other',
  color: '#FFDC00',
  children: [
    Category.create(name: 'Booze'),
    Category.create(name: 'Cycling'),
    Category.create(name: 'Toys'),
    Category.create(name: 'Games'),
    Category.create(name: 'Antiques'),
    Category.create(name: 'Pets'),
    Category.create(name: 'Camping'),
    Category.create(name: 'Tools')
  ]
)
