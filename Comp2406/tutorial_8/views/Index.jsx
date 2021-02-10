import React from 'react'

const Index = () => {
    return (
        <React.Fragment>
        <div>
            <h1>Card Database</h1>
            <p>Enter data into the filter form below and hit refresh to find matching cards.</p>
            <form name="cards" action="/cards" method="GET">
            <p>Artist: <input name="artist" /></p>
            <p>Name: <input name="name"/></p>
            <p>Min Attack: <input name="minAttack" type="number" /></p>
            <p>Max Attack: <input name="maxAttack" type="number"/></p>
            <p>Min Health: <input name="minHealth"  type="number" /></p>
            <p>Max Health: <input name="maxHealth"  type="number" /></p>
            <p>Class: <select name="cardClass" >
                <option value="NONE">NONE</option>
                <option value="DREAM">DREAM</option>
                <option value="HUNTER">HUNTER</option>
                 <option value="MAGE">MAGE</option>

                 <option value="NEUTRAL">NEUTRAL</option>
                 <option value="PRIEST">PRIEST</option>
                 <option value="SHAMAN">SHAMAN</option>
                 <option value="WARRIOR">WARRIOR</option>
                  

                </select></p>
             <p>Rarity: <select name="rarity">
                                   <option value="NONE">NONE</option>

                                <option value="COMMON">COMMON</option>
                 <option value="EPIC">EPIC</option>
                 <option value="FREE">FREE</option>
                 <option value="LEGENDARY">LEGENDARY</option>
                 <option value="RARE">RARE</option>
                 

                 </select></p>
                 <input type ="submit"/>

            </form>
        </div>
        </React.Fragment>
    )
}

export default Index
