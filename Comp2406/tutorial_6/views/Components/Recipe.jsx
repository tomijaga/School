import React from 'react'

const Recipe = ({recipe}) => {
    const style ={
    background:" rgb(2,249,255)",
background:"linear-gradient(90deg, rgba(2,249,255,1) 0%, rgba(0,129,204,1) 100%)",
    borderRadius:"20px",
    width: "auto",
    height:"auto",
    whiteSpace:"nowrap",
    padding:"0px",
    margin:"10px",
    border:"5px double azure",
    }

    const aStyle ={
width:"100%", height:"100%",
color:"black", 
fontWeight:"bold",
fontSize:"1.2rem",
textDecoration:"none"
    }

    return (
        <div style={style}>
        <a style={aStyle} href={`/recipes/${recipe._id}`} >
            <div style={{margin:"20px"}}>{recipe.name}</div>
        </a>
        </div>
    )
}

export default Recipe
