/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fr.univubs.inf1603.mahjong.interfaces.controllertest;

import fr.univubs.inf1603.mahjong.ai.BotDifficulties;
import fr.univubs.inf1603.mahjong.ai.Difficulty;
import fr.univubs.inf1603.mahjong.exceptions.UsedNameException;
import fr.univubs.inf1603.mahjong.sapi.HumanInLobby;
import fr.univubs.inf1603.mahjong.sapi.Lobby;
import fr.univubs.inf1603.mahjong.sapi.impl.HumanInLobbyImpl;
import fr.univubs.inf1603.mahjong.sapi.impl.SapiManagerImpl;
import fr.univubs.inf1603.mahjong.sapi.impl.SimpleRuleImpl;
import fr.univubs.inf1603.mahjong.tuto.*;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.InvalidNameException;

/**
 *
 * @author aster
 */
public class ControllerTest {

    SapiManagerImpl sapiManager = new SapiManagerImpl();
    HumanInLobbyImpl humanInLobby;

    /**
     * getSapiManager return the sapiManager's program
     *
     * @return SapiManagerImpl
     */
    public SapiManagerImpl getSapiManager() {
        return sapiManager;
    }

    /**
     * getVisibleLobbies return all the visible lobbies
     *
     * @return List<Lobby> a list of the visible lobbies
     */
    public List<Lobby> getVisibleLobbies() {
        return sapiManager.getVisibleLobbies();
    }

    /**
     * createHumanInLobby return a human player in a lobby
     *
     * @param name The player's name
     * @return humanInLobby A human player in a lobby
     */
    public HumanInLobbyImpl createHumanInLobby(String name) {
        humanInLobby = null;
        try {
            humanInLobby = new HumanInLobbyImpl(name);
        } catch (InvalidNameException ex) {
            Logger.getLogger(ControllerTest.class.getName()).log(Level.SEVERE, null, ex);
        }
        return humanInLobby;
    }

    /**
     * createLobby return a lobby with the specified parameters
     *
     * @param name The lobby name
     * @param owner The lobby owner
     * @param rule The rule for the lobby
     * @param visibility The visibility of the lobby
     * @param stealTime
     * @param playTime
     * @return Lobby a lobby
     */
    public Lobby createLobby(String name, HumanInLobbyImpl owner, SimpleRuleImpl rule, boolean visibility, int stealTime, int playTime) {
        Lobby lobby = null;
        try {
            lobby = sapiManager.createLobby(name, owner, rule, visibility, stealTime, playTime, BotDifficulties.Difficulty.SILLY);
        } catch (InvalidNameException | UsedNameException ex) {
            Logger.getLogger(ControllerTest.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lobby;

    }

    /**
     * createSimpleRule return a simpleRule with the specified parameters
     *
     * @param name
     * @param desc The rule description
     * @return simpleRule is a SimpleRule with the specified rules
     */
    public SimpleRuleImpl createSimpleRule(String name, String desc) {
        SimpleRuleImpl simpleRule = new SimpleRuleImpl(name, desc);
        return simpleRule;
    }

    /**
     *
     * @param uidLobby The UUID of the lobby
     * @param humanInLobby The human who want to join the game
     * @return
     */
    public boolean joinLobby(String uidLobby, HumanInLobby humanInLobby) {
        System.out.println(uidLobby);
        System.out.println("oui!!!!!!!!!!!!!!!!!!!!!!");
        UUID uuid = UUID.fromString(uidLobby);
        boolean join = sapiManager.joinLobby(uuid, humanInLobby);
        return join;
    }

    /**
     * getLobby return the lobby you want with a specified uuid
     *
     * @param uid The uuid of the lobby
     * @return lobby The lobby with the specified uuuid
     */
    public Lobby getLobby(String uid) {
        UUID uuid = UUID.fromString(uid);
        return sapiManager.getLobby(uuid);
    }

}
