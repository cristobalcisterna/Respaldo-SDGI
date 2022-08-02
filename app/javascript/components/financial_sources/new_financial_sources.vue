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
    <section class="modal-card-body" ref="newFinancialSources">
      <div class="box" >
        <b-tabs>
        <div class="columns is-centered">
          <div class="column is-centered ">
            <div class="columns">
              <div class="column">
                <b-field label="Nombre de Fuente financiera" >
                  <b-input
                    v-model="aux_name_financial_source"
                    placeholder="Ingrese el nombre de la Fuente financiera"
                  ></b-input>
                </b-field>
              </div>
            </div>
            <div class="columns">
              <div class="column">
                <b-field label="Descripción" >
                  <b-input
                    v-model="aux_detail"
                    placeholder="Ingrese la descripción de la Fuente financiera"
                  ></b-input>
                </b-field>
              </div>
              </div>
            
            <b-field grouped position="is-right" >
              <p class="control">
                <b-button
                  label="Agregar Fuente"
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
  name:"new_financial_sources",
  props:[
    'queryType', 'modalHeader'
  ],
  data() {
    return {
      selected: null,
      financial_sources: [],
      aux_name_financial_source: null,
      aux_detail: null,

    };
  },
  methods: {
    async createClick() {
      const response = await axios.post("/financial_sources.json", {
        name_financial_source: this.aux_name_financial_source,
        detail: this.aux_detail,

      });
      window.location.href = "/financial_sources";
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