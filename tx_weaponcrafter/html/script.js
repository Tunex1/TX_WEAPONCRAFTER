var toggle = false 

$(function() {
    function display(bool) {
        if (bool) {
            $(".Canvas").fadeIn(500);
        } else {
            $(".Canvas").fadeOut(500);
        }
    }
    display(false)

    window.addEventListener("message", function(event) {
        var item = event.data;
        if(item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })

    $(document).ready(function() {
        window.addEventListener("message", function(event) {
            if (event.data.action == "open") {
                const weapons = document.getElementById("weapon-list");
                weapons.innerHTML = '';
                $.post("http://tx_weaponcrafter/show", JSON.stringify({}));

                toggle = true
            } else  {
                if (event.data.action == "wep") {
                    add(event.data.name, event.data.weapon)
                }
            }
        })
    });
    

    $(".exit").click(function() {
        $.post("http://tx_weaponcrafter/close", JSON.stringify({}))
    })
})

function add(name, weapon) {
    $(".wps").append
    (`
    <div class="WeaponHolder">
    <div class="box1">
        <span id="gunname">`+name+`</span>
        <div id="munpng"></div>
        <span id="mm">7.09mm</span>
        <div id="weaponpng"></div>
        <span id="wptext">weapon upgrades</span>
        <div id="upgrades">
            <span id="item">SILENCER</span>
            <span id="gleich">=</span>
            <span id="preis">5000$</span>
            <button id="buy" onclick="buySilencer('`+ weapon +`')" data-weaponname="`+ weapon +`">BUY</button>
        </div>
        <div id="upgrades2">
            <span id="item">VISOR</span>
            <span id="gleich">=</span>
            <span id="preis">5000$</span>
            <button id="buy" onclick="buyVisor('`+ weapon +`')" data-wep="`+ weapon +`">BUY</button>
        </div>

        <div id="farmitem">
            <img id="itempic" src="img/eisen.png">
            <span id="limit">250</span>
            <span id="itemname">metal</span>
        </div>

        <div id="farmitem2">
            <img id="itempic" src="img/eisen.png">
            <span id="limit">250</span>
            <span id="itemname">metal</span>
        </div>

        <div id="farmitem3">
            <img id="itempic" src="img/eisen.png">
            <span id="limit">250</span>
            <span id="itemname">metal</span>
        </div>

        <button id="buyweapon" onclick="doo('`+ weapon +`')" data-weapon="`+ weapon +`" >BUY</button>
    </div>
</div>


    `)
}



function buySilencer(weaponname) {
    $.post("http://tx_weaponcrafter/addSilencer", JSON.stringify({
        weaponname: weaponname
    }))
    $.post("http://tx_weaponcrafter/close", JSON.stringify({}))
}

function buyVisor(wep) {
    $.post("http://tx_weaponcrafter/addVisor", JSON.stringify({
        wep: wep
    }))
    $.post("http://tx_weaponcrafter/close", JSON.stringify({}))
}

function doo(weapon) {
    $.post("http://tx_weaponcrafter/addWeapon", JSON.stringify({
        weapon: weapon
    }))
    $.post("http://tx_weaponcrafter/close", JSON.stringify({}))
}