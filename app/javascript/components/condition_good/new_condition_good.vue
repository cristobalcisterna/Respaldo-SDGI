  <template>
  <section>
    <div class="modal-card" style="width: 62em; height: auto">
      <header class="modal-card-head">
        <p class="modal-card-title">{{ modalHeader }}</p>
        <button type="button" class="delete" @click="$emit('close')" />
      </header>
      <section class="modal-card-body" ref="newConditionGood">


        <div class="box">
          <b-tabs type="is-boxed" position="is-centered">



            <b-tab-item label="Bien a dar de baja">
              <div class="columns is-centered">
                <div class="column is-centered">
                  <div class="center">
                    <h1>Dar de baja un bien</h1>
                  </div>
                  <br />


                  <div class="columns" v-show='!(aux2_good_id == null)'>
                    <div class="column">
                      <b-field label="Nombre:">
                        <b-input v-model="aux2_namegood" type="text" readonly></b-input>
                      </b-field>
                    </div>
                  </div>



                  <div class="columns">


                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Unidad">
                        <multiselect v-model="aux_unit_id" :options="units.map((type) => type.id)" :custom-label="
                          (opt) => units.find((x) => x.id === opt).name_unit
                        " placeholder="Seleccionar Unidad" selectLabel="" selectedLabel="Seleccionado"
                          deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_building_id !== null" @input="
        getbuildingbyunit(aux_unit_id);
                          ">
                        </multiselect>
                      </b-field>
                    </div>


                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Edificio">
                        <multiselect v-model="aux_building_id" :options="buildings.map((type) => type.id)"
                          :custom-label="
                            (opt) => buildings.find((x) => x.id === opt).name_building
                          " placeholder="Seleccionar Unidad" selectedLabel="Seleccionado"
                          deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_unit_id == null || aux_office_id !== null"
                          @input="getofficebybuilding(aux_building_id)">

                        </multiselect>
                      </b-field>
                    </div>
                  </div>
                  <div class="columns">
                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Dependencia">
                        <multiselect v-model="aux_office_id" :options="offices.map((type) => type.id)" :custom-label="
                          (opt) => offices.find((x) => x.id === opt).name_office
                        " placeholder="Seleccionar dependencia" selectLabel="Presione para seleccionar"
                          selectedLabel="Seleccionado" deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_building_id == null || aux_good_id !== null"
                          @input="getgoodbyoffice(aux_office_id)">
                        </multiselect>
                      </b-field>
                    </div>


                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Bien">
                        <multiselect v-model="aux_good_id" :options="goods.map((type) => type.id)" :custom-label="
                          (opt) =>
                            goods.find((x) => x.id === opt).namegood
                        " placeholder="Seleccionar Bien" selectLabel="Presione para seleccionar"
                          selectedLabel="Seleccionado" deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_office_id == null">
                        </multiselect>
                      </b-field>
                    </div>
                  </div>

 
                  <div class="columns">
                    <div class="column">
                      <b-field label="Motivo de ingreso">
                        <b-input v-model="aux_income_reason" placeholder="Ingrese detalles del motivo de ingreso"
                          type="textarea"></b-input>
                      </b-field>
                    </div>
                  </div>

                  <div class="columns">
                    <div class="column">
                      <b-field label="URL de documento enlace">
                        <b-input v-model="aux_link" placeholder="Ingrese la URL del documento correspondiente">
                        </b-input>
                      </b-field>
                    </div>
                  </div>


                  <b-field grouped position="is-right" v-show='!(aux2_good_id != null)'>
                    <p class="control">
                      <b-button label="Solicitar dar de baja" type="is-info" @click="reportRequest()" />
                                   </p>
                  </b-field>


                      <b-field grouped position="is-right" v-show='!(aux2_good_id == null)'>
                        <p class="control">
                          <b-button label="Solicitar dar de baja" type="is-info" @click="reportRequestaux()" />
                        </p>
                      </b-field>


       
                </div>
              </div>
            </b-tab-item>





            <!-- Comment

                <b-step-item step="2" label="Informar bien para enviar a la bodega de excluidos" :clickable="true">
            <div class="columns">

                              <div class="column">
                <b-field label="Bienes">
                  <multiselect
                    v-model="aux_good_id"
                    :options="goods.map((type) => type.id)"
                    :custom-label="
                      (opt) =>
                        goods.find((x) => x.id === opt).namegood
                    "
                    placeholder="Seleccionar Bien"
                    selectLabel="Presione para seleccionar"
                    selectedLabel="Seleccionado"
                    deselectLabel="Presione para deseleccionar"
                    :allow-empty="true"
                  >
                  </multiselect>
                </b-field>
              </div>


            </div>
           
            <div class="columns">

              <div class="column">
                <b-field label="Fecha de solicitud">
                  <b-datepicker
                    v-model="aux_request_date"
                    locale="es-ES"
                    placeholder="Seleccionar fecha de solicitud"
                    trap-focus
                  >
                  </b-datepicker>
                </b-field>
              </div>

                            <div class="column">
                <b-field label="Fecha de ingreso">
                  <b-datepicker
                    v-model="aux_date_entry"
                    locale="es-ES"
                    placeholder="Seleccionar fecha de ingreso"
                    trap-focus
                  >
                  </b-datepicker>
                </b-field>
              </div>
            </div>




                         <div class="columns">
              
              <div class="column">
                <b-field label="Motivo de ingreso">
                  <b-input
                    v-model="aux_income_reason"
                    placeholder="Ingrese detalles del motivo de ingreso"
                    type="textarea"
                  ></b-input>
                </b-field>
              </div>
            </div>


            <b-field grouped position="is-right">
              <p class="control">
                <b-button
                  label="Agregar Bien"
                  type="is-info"
                  @click="reportExcluded()"
                />
              </p>
            </b-field>
            </b-step-item>

 -->

            <b-tab-item label="Informar bien Perdido">
              <div class="columns is-centered">
                <div class="column is-centered">
                  <div class="center">
                    <h1>Informar bien Perdido</h1>
                  </div>
                  <br />


                  <div class="columns" v-show='!(aux2_good_id == null)'>
                    <div class="column">
                      <b-field label="Nombre:">
                        <b-input v-model="aux2_namegood" type="text" readonly></b-input>
                      </b-field>
                    </div>
                  </div>

                  <div class="columns">


                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Unidad">
                        <multiselect v-model="aux_unit_id" :options="units.map((type) => type.id)" :custom-label="
                          (opt) => units.find((x) => x.id === opt).name_unit
                        " placeholder="Seleccionar Unidad" selectLabel="" selectedLabel="Seleccionado"
                          deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_building_id !== null" @input="
        getbuildingbyunit(aux_unit_id);
                          ">
                        </multiselect>
                      </b-field>
                    </div>


                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Edificio">
                        <multiselect v-model="aux_building_id" :options="buildings.map((type) => type.id)"
                          :custom-label="
                            (opt) => buildings.find((x) => x.id === opt).name_building
                          " placeholder="Seleccionar Unidad" selectedLabel="Seleccionado"
                          deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_unit_id == null || aux_office_id !== null"
                          @input="getofficebybuilding(aux_building_id)">

                        </multiselect>
                      </b-field>
                    </div>
                  </div>
                  <div class="columns">
                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Dependencia">
                        <multiselect v-model="aux_office_id" :options="offices.map((type) => type.id)" :custom-label="
                          (opt) => offices.find((x) => x.id === opt).name_office
                        " placeholder="Seleccionar dependencia" selectLabel="Presione para seleccionar"
                          selectedLabel="Seleccionado" deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_building_id == null || aux_good_id !== null"
                          @input="getgoodbyoffice(aux_office_id)">
                        </multiselect>
                      </b-field>
                    </div>


                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Bien">
                        <multiselect v-model="aux_good_id" :options="goods.map((type) => type.id)" :custom-label="
                          (opt) =>
                            goods.find((x) => x.id === opt).namegood
                        " placeholder="Seleccionar Bien" selectLabel="Presione para seleccionar"
                          selectedLabel="Seleccionado" deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_office_id == null">
                        </multiselect>
                      </b-field>
                    </div>

                  </div>

                  <div class="columns">

                    <div class="column">
                      <b-field label="Fecha de perdida">
                        <b-datepicker v-model="aux_lost_date" locale="es-ES" placeholder="Seleccionar fecha de perdida"
                          trap-focus>
                        </b-datepicker>
                      </b-field>
                    </div>
                  </div>

                  
                  <div class="columns">

                    <div class="column">
                      <b-field label="Descripción de perdida">
                        <b-input v-model="aux_loss_detail" placeholder="Ingrese detalles de la perdida del bien"
                          type="textarea"></b-input>
                      </b-field>
                    </div>
                  </div>

                  <div class="columns">

                    <div class="column">
                      <b-field label="URL de documento enlace">
                        <b-input v-model="aux_link" placeholder="Ingrese la URL del documento correspondiente">
                        </b-input>
                      </b-field>
                    </div>
                  </div>


                  <b-field grouped position="is-right" v-show='!(aux2_good_id != null)'>
                    <p class="control">
                      <b-button label="Informar pérdida" type="is-info" @click="reportLost()" />
                    </p>
                  </b-field>

                  <b-field grouped position="is-right" v-show='!(aux2_good_id == null)'>
                    <p class="control">
                      <b-button label="Informar pérdida" type="is-info" @click="reportLostaux()" />
                    </p>
                  </b-field>
                </div>
              </div>
            </b-tab-item>






            <b-tab-item label="Informar bien Destruido">
              <div class="columns is-centered">
                <div class="column is-centered">

                  <div class="center">
                    <h1>Informar bien Destruido</h1>
                  </div>
                  <br />

                  <div class="columns" v-show='!(aux2_good_id == null)'>
                    <div class="column">
                      <b-field label="Nombre:">
                        <b-input v-model="aux2_namegood" type="text" readonly></b-input>
                      </b-field>
                    </div>
                  </div>
                  <div class="columns">


                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Unidad">
                        <multiselect v-model="aux_unit_id" :options="units.map((type) => type.id)" :custom-label="
                          (opt) => units.find((x) => x.id === opt).name_unit
                        " placeholder="Seleccionar Unidad" selectLabel="" selectedLabel="Seleccionado"
                          deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_building_id !== null" @input="
        getbuildingbyunit(aux_unit_id);
                          ">
                        </multiselect>
                      </b-field>
                    </div>


                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Edificio">
                        <multiselect v-model="aux_building_id" :options="buildings.map((type) => type.id)"
                          :custom-label="
                            (opt) => buildings.find((x) => x.id === opt).name_building
                          " placeholder="Seleccionar Unidad" selectedLabel="Seleccionado"
                          deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_unit_id == null || aux_office_id !== null"
                          @input="getofficebybuilding(aux_building_id)">

                        </multiselect>
                      </b-field>
                    </div>
                  </div>
                  <div class="columns">
                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Dependencia">
                        <multiselect v-model="aux_office_id" :options="offices.map((type) => type.id)" :custom-label="
                          (opt) => offices.find((x) => x.id === opt).name_office
                        " placeholder="Seleccionar dependencia" selectLabel="Presione para seleccionar"
                          selectedLabel="Seleccionado" deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_building_id == null || aux_good_id !== null"
                          @input="getgoodbyoffice(aux_office_id)">
                        </multiselect>
                      </b-field>
                    </div>


                    <div class="column" v-show='!(aux2_good_id != null)'>
                      <b-field label="Bien">
                        <multiselect v-model="aux_good_id" :options="goods.map((type) => type.id)" :custom-label="
                          (opt) =>
                            goods.find((x) => x.id === opt).namegood
                        " placeholder="Seleccionar Bien" selectLabel="Presione para seleccionar"
                          selectedLabel="Seleccionado" deselectLabel="Presione para deseleccionar" :allow-empty="true"
                          :disabled="aux_office_id == null">
                        </multiselect>
                      </b-field>
                    </div>

                  </div>
                  <div class="columns">

                    <div class="column">
                      <b-field label="Fecha de destrcción">
                        <b-datepicker v-model="aux_destruction_date" locale="es-ES"
                          placeholder="Seleccionar fecha de destrcción" trap-focus>
                        </b-datepicker>
                      </b-field>
                    </div>
                  </div>

                  
                  <div class="columns">

                    <div class="column">
                      <b-field label="Descripción de la destrucción">
                        <b-input v-model="aux_destruction_detail"
                          placeholder="Ingrese detalles de la destrucción del bien" type="textarea"></b-input>
                      </b-field>
                    </div>
                  </div>

                  <div class="columns">
                    <div class="column">
                      <b-field label="Reparable">

                        <multiselect v-model="aux_repairable" :options="reparable" placeholder="¿Es reaparable?"
                          selectLabel="Presione para seleccionar" selectedLabel="Seleccionado"
                          deselectLabel="Presione para deseleccionar" :allow-empty="true">
                        </multiselect>
                      </b-field>
                    </div>
                  </div>

                  <div class="columns">
                    <div class="column">
                      <b-field label="URL de documento enlace">
                        <b-input v-model="aux_link" placeholder="Ingrese la URL del documento correspondiente">
                        </b-input>
                      </b-field>
                    </div>
                  </div>



                  <b-field grouped position="is-right" v-show='!(aux2_good_id != null)'>
                    <p class="control">
                      <b-button label="Informar bien destruido" type="is-info" @click="reportDestruction()" />
                    </p>
                  </b-field>

                  <b-field grouped position="is-right" v-show='!(aux2_good_id == null)'>
                    <p class="control">
                      <b-button label="Informar bien destruido" type="is-info" @click="reportDestructionaux()" />
                    </p>
                  </b-field>


                </div>
              </div>
            </b-tab-item>



          </b-tabs>
        </div>
      </section>
    </div>
  </section>
</template>

<script>
import axios from "axios";
export default {
  name: "new_good_condition",
  props: [
    'queryType', 'modalHeader', "id", "goodId"
  ],
  data() {
    return {
      selected: null,
      goods: [],
      offices: [],
      units: [],
      managers: [],
      buildings: [],
      aux_office_id: null,
      aux_unit_id: null,
      aux_building_id: null,
      reparable: ['SI', 'NO'],
      aux_link: null,
      aux_namegood: null,
      aux2_namegood: null,
      aux2_good_id: null,
      aux_lost_date: new Date(),
      aux_loss_detail: null,

      aux_destruction_date: new Date(),
      aux_destruction_detail: null,
      aux_repairable: null,

      aux_request_date: new Date(),
      aux_request_status: null,
      aux_income_reason: null,
      aux_date_entry: new Date(),

      aux_good_id: null,
      aux_condition_id: null,

      aux_activegood: 1,
    };
  },
  methods: {
    async getgood() {
      const response = await axios.get("/goods/" + this.id + ".json");
      this.loading = true;
      this.good = response.data;
      this.aux2_namegood = this.good.namegood;
      this.aux2_good_id = this.good.id;
      console.log(this.aux2_namegood);
      console.log(this.aux2_good_id);

    },
    async getgoods() {
      const response = await axios.get("http://localhost:3000/goods.json");
      this.goods = response.data;
      console.log(this.goods);
    },

    async getunit() {
      const response = await axios.get("http://localhost:3000/units.json");
      this.units = response.data;

    },

    async getbuildingbyunit(item) {
      const response = await axios.get(
        "http://localhost:3000/buildings/showbuildingunit/" + item + ".json"
      );
      this.buildings = response.data;
      console.log(this.buildings);
    },

    async getofficebybuilding(item) {
      const response = await axios.get(
        "http://localhost:3000/offices/showofficebuilding/" + item + ".json"
      );
      this.offices = response.data;
      console.log(this.offices);
    },
    async getgoodbyoffice(item) {
      const response = await axios.get("/goods/showgoodoffice/" + item + ".json");
      this.goods = response.data;
    },





    async reportLost() {
      const response = await axios.post("/condition_goods.json", {
        lost_date: this.aux_lost_date,
        loss_detail: this.aux_loss_detail,
        link: this.aux_link,
        good_id: this.aux_good_id,
        condition_id: 3,
        activeconditiongood: 1,
      });
      window.location.href = "/condition_goods";
    },

    async reportLostaux() {
      const response = await axios.post("/condition_goods.json", {
        lost_date: this.aux_lost_date,
        loss_detail: this.aux_loss_detail,
        link: this.aux_link,
        good_id: this.aux2_good_id,
        condition_id: 3,
        activeconditiongood: 1,
      });
      window.location.href = "/condition_goods";
    },

    async reportDestruction() {
      const response = await axios.post("/condition_goods.json", {
        destruction_date: this.aux_destruction_date,
        destruction_detail: this.aux_destruction_detail,
        repairable: this.aux_repairable,
        link: this.aux_link,
        good_id: this.aux_good_id,
        condition_id: 4,
        activeconditiongood: 1,
      });
      console.log(this.condition_id);
      console.log(this.aux_good_id);
      window.location.href = "/condition_goods";
    },

    async reportDestructionaux() {
      const response = await axios.post("/condition_goods.json", {
        destruction_date: this.aux_destruction_date,
        destruction_detail: this.aux_destruction_detail,
        repairable: this.aux_repairable,
        link: this.aux_link,
        good_id: this.aux2_good_id,
        condition_id: 4,
        activeconditiongood: 1,
      });
      console.log(this.condition_id);
      console.log(this.aux2_good_id);
      window.location.href = "/condition_goods";
    },



    //async reportExcluded() {
    //  const response = await axios.post("/condition_goods.json", {
    //    request_date: this.aux_request_date,
    //    request_status: this.aux_request_status,
    //    income_reason: this.aux_income_reason,
    //    date_entry: this.aux_date_entry,
    //    link: this.aux_link,
    //    good_id: this.aux_good_id,
    //    condition_id: 2,});
    //  console.log(this.goods);
    //  window.location.href = "/condition_goods";},

    async reportRequest() {
      const response = await axios.post("/condition_goods.json", {

        request_date: this.aux_request_date,
        request_status: this.aux_request_status,
        income_reason: this.aux_income_reason,
        link: this.aux_link,
        good_id: this.aux_good_id,
        condition_id: 1,
        activeconditiongood: 1,

      });
      console.log(this.goods);
      window.location.href = "/condition_goods";
    },

    async reportRequestaux() {
      const response = await axios.post("/condition_goods.json", {

        request_date: this.aux_request_date,
        request_status: this.aux_request_status,
        income_reason: this.aux_income_reason,
        link: this.aux_link,
        good_id: this.aux2_good_id,
        condition_id: 1,
        activeconditiongood: 1,

      });
      console.log(this.goods);
      window.location.href = "/condition_goods";
    },







    confirmregister() {
      this.$buefy.dialog.confirm({
        title: "Registrar el Bien",
        message: `¿Esta seguro de registrar esté bien?`,
        cancelText: "Cancelar",
        confirmText: "Registrar",
        type: "is-info",
        onConfirm: () => this.createClick(),
      });
    },
    deleteDropFile(index) {
      this.dropFiles.splice(index, 1)
    },
  },
  created() {
    this.getgoods();
    this.getgood();
    this.getunit();

  },
};
</script>