<template>
  <section>
        <div class="modal-card" style="width: 62em; height: auto">
      <header class="modal-card-head">
        <p class="modal-card-title">{{ modalHeader }}</p>
        <button type="button" class="delete" @click="$emit('close')" />
      </header>
      <section class="modal-card-body" ref="editConditionGood">

        <b-tabs>
          <div class="box">
            <div v-if="condition_good" class="columns is-centered">
              <div class="column is-centered">
        
                    <div class="center"><h1>Datos del estado del Bien</h1></div>

                    <div class="columns">
                      <div class="column"  v-show='!(condition_good.income_reason == null)'>
                        <b-field label="Motivo de ingreso">
                          <b-input
                            v-model="condition_good.income_reason"
                            type="textarea"
                            placeholder="Ingrese detalles del motivo de ingreso"
                          ></b-input>
                        </b-field>

                      </div>

                      <div class="column"  v-show='!(condition_good.loss_detail == null)'>
                        <b-field label="Descripción de perdida">
                          <b-input
                            v-model="condition_good.loss_detail"
                            type="textarea"
                            placeholder="Ingrese detalles de la perdida del bien"
                          ></b-input>
                        </b-field>

                      </div>
                      <div class="column"  v-show='!(condition_good.destruction_detail == null)'>
                        <b-field label="Descripción de destrucción">
                          <b-input
                            v-model="condition_good.destruction_detail"
                            type="textarea"
                            placeholder="Ingrese detalles de la destrucción del bien"
                          ></b-input>
                        </b-field>
         
                      </div>
                    </div>

                    <div class="columns">
                      <div class="column"  v-show='!(condition_good.repairable == null)'>
                        <b-field label="¿Es reparable?">
                        <multiselect v-model="aux_repairable" :options="reparable" placeholder="¿Es reaparable?"
                          selectLabel="Presione para seleccionar" selectedLabel="Seleccionado"
                          deselectLabel="Presione para deseleccionar" :allow-empty="true">
                        </multiselect>
                              </b-field>
                      </div>
                      </div>
                                        <div class="columns">
                      <div class="column">
                       <b-field label="Link de documento enlace">
                        <b-input v-model="condition_good.link" placeholder="Ingrese el link del documento correspondiente">
                        </b-input>
                      </b-field>
                      </div>
                      </div>


                    <b-field grouped position="is-right">
                      <p class="control">
                        <b-button
                          label="Guardar"
                          type="is-info"
                          @click="confirmedit()"
                        />
                      </p>
                    </b-field>
              </div>
            </div>

            <div v-else>
              <p>Loading</p>
            </div>
          </div>
        </b-tabs>
        </section>
    </div>
      </section>
</template>


<script>
import axios from "axios";
import moment from "moment";
export default {
  props: ["queryType", "modalHeader", "condition_goodId", "id", "goodId"],
  data() {
    return {
      condition_good: null,
      goods: [],
      props: ["id"],
      aux_repairable: null,
      reparable: ['SI', 'NO'],

    };
  },
  methods: {
    async getconditiongoods() {
      const response = await axios.get("/condition_goods/" + this.id + ".json");
      this.condition_good = response.data;
      console.log(this.auxdate);
    },
  
    async EditClick() {
      const response = await axios.put("/condition_goods/" + this.id + ".json", {
        income_reason: this.condition_good.income_reason,
        loss_detail: this.condition_good.loss_detail,
        link: this.condition_good.link,
        destruction_detail: this.condition_good.destruction_detail,
        repairable: this.aux_repairable,
      });
      window.location.href = "/condition_goods/" + this.id;
    },

    confirmedit() {
      this.$buefy.dialog.confirm({
        title: "Editar el Bien",
        message: `¿Esta seguro de editar el detalle del estado?`,
        cancelText: "Cancelar",
        confirmText: "Guardar",
        type: "is-info",
        onConfirm: () => this.EditClick(),
      });
    },
  },
  created() {
    this.getconditiongoods();
  },
};
</script>




