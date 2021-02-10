import React from 'react';
import Recipe from './Components/Recipe.jsx';

const Index = ({recipes}) => {
    const displayRecipes=()=>{
        return (recipes||[]).map((recipe,i)=>{
            return (<Recipe key={i} recipe={recipe}/>)
        })
    }

    const style ={minWidth:"100vw", minHeight:"100vh",display:"flex",flexDirection:"column", alignItems:"center"}
    return (
        <React.Fragment >
            <div style={style} >
            <h1>Recipes</h1>
            <div style={{display:"flex", flexWrap:"wrap", justifyContent:"center"}}>{displayRecipes()}</div>
            
            </div>
        </React.Fragment>
    )
}

export default Index;
