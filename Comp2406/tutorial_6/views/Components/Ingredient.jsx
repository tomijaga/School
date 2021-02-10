import React from 'react'

const Ingredient = ({ingredient}) => {
    console.log("start")
    console.log(ingredient)
    const {name, unit, amount} = ingredient;
   
    return (
 <div style={{margin:"5px"}} >
            <h5>{name}: {`${amount} ${unit}${amount>1?"'s":""}`}</h5>
        </div>
        
    )
}

export default Ingredient;