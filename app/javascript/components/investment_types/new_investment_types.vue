  <template>
  <section>

 <div class="modal-card" style="width: 45em; height: auto">
    <header class="modal-card-head">
      <p class="modal-card-title">{{modalHeader}}</p>
      <button
          type="button"
          class="delete"
          @click="$emit('close')"/>
    </header>
    <section class="modal-card-body" ref="NewInvestmentTypes">
      <div class="box" >
        <b-tabs>
        <div class="columns is-centered">
          <div class="column is-centered ">
            <div class="columns">
              <div class="column">
                <b-field label="Nombre Tipo de inversión" >
                  <b-input
                    v-model="aux_name_investment_type"
                    placeholder="Ingrese el nombre de la Tipo de inversión"
                  ></b-input>
                </b-field>
              </div>
            </div>
            <div class="columns">
              <div class="column">
                <b-field label="Descripción" >
                  <b-input
                    v-model="aux_detail"
                    placeholder="Ingrese la descripción del Tipo de inversión"
                  ></b-input>
                </b-field>
              </div>
              </div>
            
            <b-field grouped position="is-right" >
              <p class="control">
                <b-button
                  label="Agregar Tipo de inversión"
                  type="is-info"
                  @click="confirmregister()"
                />
              </p>
            </b-field>
          </div>
        </div></b-tabs> </div
    >
    </section>
 </div>
  </section>
</template>

<script>
import axios from "axios";
export default {
  name:"new_investment_types",
  props:[
    'queryType', 'modalHeader'
  ],
  data() {
    return {
      selected: null,
      investment_types: [],
      aux_name_investment_type: null,
      aux_detail: null,

    };
  },
  methods: {
    async createClick() {
      const response = await axios.post("/investment_types.json", {
        name_investment_type: this.aux_name_investment_type,
        detail: this.aux_detail,

      });
      window.location.href = "/investment_types";
    },

    confirmregister() {
      this.$buefy.dialog.confirm({
        title: "Registrar Unidad",
        message: `¿Esta seguro de registrar esta unidad?`,
        cancelText: "Cancelar",
        confirmText: "Registrar",
        type: "is-info",
        onConfirm: () => this.createClick(),
      });
    },
  },
};
</script>