/**
 * Created by odupre on 09/03/17.
 *
 * IMPORTANT :
 * Le nom des agents auto-provisionnés est défini dans la configuration du plugin digitalOcean.
 */
node("docker") {
    echo "Running"
    docker.build("toulouse-jam/spring-petclinic:${env.BUILD_NUMBER}")
}
