tools = [
    Tool(
        name="WasteRecycling_Locations",
        func=wasterecycling_location().run,
        description="Find the nearest waste recycling location"
    ),

    Tool( 
        name="Surplus_Food_Recovery_Locations",
        func=surplus_food_recovery().run,
        description="Find the type of surplus food recovery location"
    )
]