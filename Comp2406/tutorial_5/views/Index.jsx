import React from "react";


const Index = ({ cards }) => {
  const displayCards = () => {
    if (cards) {
      return cards.map((card, i) => {
        return (
        
           <a key={i} className="card" style={{textDecoration:"none"}} href ={"/cards/"+card.id}> 
            <div style={{border:"3px groove azure",padding:"10px", fontSize:"1.2rem",color:"black", width: "100px", height:"60px", display:"flex", alignItems:"center" }} >
              {card.name}
              </div>
            
              </a>
           
        );
      });
    }
  };

  const style = {
    minWidth: "100vw",
    minHeight: "100vh",
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
  };

  return (
    <React.Fragment>
      <div style={style}>
        <h1>Cards</h1>
        <div
          style={{
            display: "flex",
            flexWrap: "wrap",
            justifyContent: "center",
          }}
        >
          {displayCards()}
        </div>
      </div>
    </React.Fragment>
  );
};

export default Index;
