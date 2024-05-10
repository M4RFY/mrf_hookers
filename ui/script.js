const mrf_Hookers = new Vue({
    el: "#mrf_Hookers",

    data: {
        // Shared
        ResourceName: "mrf_hookers",
        showHookersSelector: false,
        showPimpSelector: false,
        blowjob: null,
        sex: null,

    },

    methods: {

        // START OF MAIN MENU
        OpenPimpMenu() {
            this.showPimpSelector = true;
            this.showHookersSelector = false;

        },

        OpenHookersMenu(blowjob, sex) {
            this.showHookersSelector = true;
            this.showPimpSelector = false;
            this.blowjob = blowjob;
            this.sex = sex;

        },

        CloseHookersMenu() {
            axios.post(`https://${this.ResourceName}/CloseMenu`, {}).then((response) => {
                this.showHookersSelector = false;
                this.showPimpSelector = false;
            }).catch((error) => { });
        },

        ChooseMolly() {
            axios.post(`https://${this.ResourceName}/ChooseMolly`, {}).then((response) => {
                this.showHookersSelector = false;
                this.showPimpSelector = false;
            }).catch((error) => { });
        },

        ChooseLiza() {
            axios.post(`https://${this.ResourceName}/ChooseLiza`, {}).then((response) => {
                this.showHookersSelector = false;
                this.showPimpSelector = false;
            }).catch((error) => { });
        },

        ChooseJessica() {
            axios.post(`https://${this.ResourceName}/ChooseJessica`, {}).then((response) => {
                this.showHookersSelector = false;
                this.showPimpSelector = false;
            }).catch((error) => { });
        },

        ChooseKara() {
            axios.post(`https://${this.ResourceName}/ChooseKara`, {}).then((response) => {
                this.showHookersSelector = false;
                this.showPimpSelector = false;
            }).catch((error) => { });
        },

        ChooseBlowjob() {
            axios.post(`https://${this.ResourceName}/ChooseBlowjob`, {}).then((response) => {
                this.showHookersSelector = false;
                this.showPimpSelector = false;
            }).catch((error) => { });
        },

        ChooseSex() {
            axios.post(`https://${this.ResourceName}/ChooseSex`, {}).then((response) => {
                this.showHookersSelector = false;
                this.showPimpSelector = false;
            }).catch((error) => { });
        },

        CloseServiceMenu() {
            axios.post(`https://${this.ResourceName}/CloseServiceMenu`, {}).then((response) => {
                this.showHookersSelector = false;
                this.showPimpSelector = false;
            }).catch((error) => { });
        },


    },
});

// Listener from Lua CL
document.onreadystatechange = () => {
    if (document.readyState == "complete") {
        window.addEventListener("message", (event) => {
            if (event.data.type == "openPimpMenu") {
                mrf_Hookers.OpenPimpMenu(event.data.blowjob, event.data.sex);
            } else if (event.data.type == "openHookerMenu") {
                mrf_Hookers.OpenHookersMenu(event.data.blowjob, event.data.sex);
            }
        });
    }
}