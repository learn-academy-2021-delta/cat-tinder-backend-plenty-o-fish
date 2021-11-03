fish = [
    {
        name: 'Nala',
        age: 4,
        enjoys: 'Big squeezes'
    },
    {
        name: 'Pearl',
        age: 3,
        enjoys: 'Shells'
    },
    {
        name: 'Jorge',
        age: 11,
        enjoys: 'Danger'
    },
    {
        name: 'Buttah',
        age: 51,
        enjoys: 'Mindfullness'
    },
    {
        name: 'Split',
        age: 6,
        enjoys: 'Nothing but everything'
    },
    {
        name: 'Whiskeytengofoxtrot',
        age: 3,
        enjoys: 'Ruining your life'
    }
]

fish.each do |attributes|
    fish.create attributes
    p "creating fish #{attributes}"
end 
