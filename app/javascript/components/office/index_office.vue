<template>
  <section class="b-tooltips"> 
    <div class="box" style="margin-top: 60px; margin-left: 300px; margin-right: 300px;">
      <h1>Dependencias de la facultad</h1>
      <b-tabs>
        <b-tab-item>
                     <div class="has-text-right">
              <b-button
                label="Añadir dependencia"
                type="is-info"
                icon-left="plus"
                @click="createOffice()"
              ></b-button>
            </div>
 
            <div>
                  <b-modal
          :active="isModalActive"
          aria-modal
          has-modal-card
          :destroy-on-hide="true"
          aria-role="dialog"
          width="100%"
          :can-cancel="canCancel">
        <template>
          <new-office modal-cancel="true"
                            :modal-header="'Registro de Dependencia'"
                            query-type="create"
                            @close="closeModalCreate"></new-office>
        </template>
      </b-modal>

      </div>

          <div class="column">
            <b-table 
            :data="offices"
            :paginated=true 
                per-page="8"
                striped
                hoverable
                :pagination-simple=false
                pagination-position="bottom"
                default-sort-direction="asc" 
                sort-icon="arrow-up"
                sort-icon-size="is-small"
                default-sort="inventores.name"
                aria-next-label="Siguiente"
                aria-previous-label="Anterior"
                aria-page-label="Página"
                aria-current-label="Página actual">
              <b-table-column :visible=false field="id" label="ID" sortable searchable>

                <template v-slot="props">
                  {{ props.row.id }}
                </template>
              </b-table-column>

              <b-table-column
                field="name_office"
                label="Nombre dependencia"
                sortable
                searchable
              >

                <template v-slot="props">
                <a href="#" @click="Clickshowoffice(props.row.id)">{{ props.row.name_office }}</a>
                </template>
              </b-table-column>

              <b-table-column
                field="identification_number_office"
                label="N° Identificación"
                sortable
                searchable
              >

                <template v-slot="props">
                  {{ props.row.identification_number_office }}
                </template>
              </b-table-column>

              <b-table-column
                field="duty_manager.name_duty_manager"
                label="Nombre Persona encargada"
                sortable
                searchable
              >

                <template v-slot="props">
                 <a href="#" @click="Clickshowdutymanager(props.row.duty_manager_id)">{{ props.row.duty_manager.name_duty_manager }}</a>
                </template>
              </b-table-column>

              <b-table-column
                field="building.name_building"
                label="Edificio"
                sortable
                searchable
              >

                <template v-slot="props">
                <a href="#" @click="Clickshowbuilding(props.row.building_id)">{{ props.row.building.name_building }}</a>
            
                </template>
              </b-table-column>

              <b-table-column
                field="location"
                label="Ubicación"
                sortable
                searchable
              >

                <template v-slot="props">
                  {{ props.row.location }}
                </template>
              </b-table-column>

              <b-table-column field="id" width="10"  v-slot="props">
                <b-tooltip label="Ver detalle" type="is-info">
               <b-icon
              pack="fas"
              icon="eye"
              size="is-medium"
              @click.native="Clickshowoffice(props.row.id)"/>
              </b-tooltip>
              </b-table-column>

            </b-table>
          </div>
        </b-tab-item>
      </b-tabs>
    </div>
  </section>
</template>

 
<script>
import axios from "axios";
import NewOffice from './new_office.vue';
import ShowOffice from './show_office.vue';
export default {

  data() {
    return {
      offices: [],
      canCancel: ["escape"],
      isModalActive: false,
      isModalActiveShow: false,
      selected: null,
    };
  },
    components: { NewOffice, ShowOffice },
  methods: {
    async getoffices() {
      const response = await axios.get("http://localhost:3000/offices.json");
      this.offices = response.data;
    },
     async Clicknewoffice() {
      const response = (window.location.href = "/offices/new");
    },
    async Clickshowoffice(item) {
      const response = (window.location.href = "/offices/" + item );
    },
     async Clickshowunit(item) {
      const response = (window.location.href = "/units/" + item);
    },
      async Clickshowgood(item) {
      const response = (window.location.href = "/goods/" + item);
      console.log(this.item);
    },
        async Clickshowdutymanager(item) {
      const response = (window.location.href = "/duty_managers/" + item );
    },
            async Clickshowbuilding(item) {
      const response = (window.location.href = "/buildings/" + item );
    },
    async createOffice(){
      this.isModalActive = true;
    },
    async closeModalCreate(){
      this.isModalActive = false;
    },
        async ShowModalOffice(item) {
      this.selected = item;
      this.isModalActiveShow = true;
    },
    async closeModalShow() {
      this.isModalActiveShow = false;
    },

  },
  created() {
    this.getoffices();
  },
};
</script>