import React from 'react';
import Ingredient from './Components/Ingredient.jsx';

const RecipePage = ({recipe}) => {
    const displayIngredients=()=>{
        return (recipe.ingredients||[]).map((spice, i)=>{
            return (<Ingredient key={i} ingredient={spice}/>)
        })
    }

    return (
        <div style={{position:"absolute", top:"30%", left:"50%", transform:"translate(-50%, -50%)", width:"minmax(300px, 50vw)", fontSize:"1.2rem"}}>
            <h2>{recipe.name}</h2>
           
                <h4>Preparation Time: {" "+recipe.preptime|| recipe.cooktime}</h4>
                
    
    <p>{recipe.description}</p>

    <div style={{display:"flex", flexWrap:"wrap"}}>
            {displayIngredients()}
    </div>
            
        </div>
    )
}

export default RecipePage;
