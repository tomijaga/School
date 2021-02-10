import React from 'react'

const CardPage = ({card}) => {
     return (
        <div style={{position:"absolute", top:"50%", left:"50%", transform:"translate(-50%, -50%)", width:"minmax(300px, 50vw)", fontSize:"1.2rem"}}>
            <h2>{card.name}</h2>
           
                <h4>Artist: {" "+card.artist|| "--"}</h4>
                
                <div style={{flexDirection:"row", display:"flex", justifyContent:"space-between"}}>
                    <div style={{ flexDirection:"column",width:"auto", height:"100px", display:"flex", justifyContent:"space-evenly"}} >
          
                       <span><b>set:</b>{card.set|| "--"}</span>
                       <span><b>class:</b>{card.cardClass|| "--"}</span>

                    </div>
                
                    <div  style={{ flexDirection:"column",width:"auto", height:"100px", display:"flex", justifyContent:"space-evenly"}}>
                       <span><b>id:</b> {card.id|| "--"}</span>
                        <span><b>type:</b>{card.type|| "--"}</span>
                    </div>

    

                </div>

{card.rarity? <p style={{display:"flex", }}>
    {card.attack?(<div>
                    <div>Attack</div>
                    <div style={{ background:" rgb(2,249,255)",
background:"linear-gradient(90deg, rgba(2,249,255,1) 0%, rgba(0,129,204,1) 100%)",
     borderRadius:"10px", color:"black", padding:"5px" }}>{card.attack}</div>
                </div>):<></>}
     
                {card.health?(<div>
                    <div>Health</div>
                    <div style={{ background:" rgb(2,249,255)",
background:"linear-gradient(90deg, rgba(2,249,255,1) 0%, rgba(0,129,204,1) 100%)",
     borderRadius:"10px", color:"black", padding:"5px" }}>{card.health}</div>
                </div>) :<></>}
                 
                 {card.rarity?( <div>
                    <div>Rarity</div>
                    <div style={{ background:" rgb(2,249,255)",
background:"linear-gradient(90deg, rgba(2,249,255,1) 0%, rgba(0,129,204,1) 100%)",
     borderRadius:"10px", color:"black", padding:"5px" }}>{card.rarity}</div>
                </div>):<></>}
   
                

                </p>:<></>}
               
    
    <p>{card.text}</p>
            
        </div>
    )
}

export default CardPage
