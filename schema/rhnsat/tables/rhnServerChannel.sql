--
-- Copyright (c) 2008 Red Hat, Inc.
--
-- This software is licensed to you under the GNU General Public License,
-- version 2 (GPLv2). There is NO WARRANTY for this software, express or
-- implied, including the implied warranties of MERCHANTABILITY or FITNESS
-- FOR A PARTICULAR PURPOSE. You should have received a copy of GPLv2
-- along with this software; if not, see
-- http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
-- 
-- Red Hat trademarks are not licensed under GPLv2. No permission is
-- granted to use or replicate Red Hat trademarks that are incorporated
-- in this software or its documentation. 
--
--
-- $Id$
--

create table rhnServerChannel
(
	server_id	number
			constraint rhn_sc_sid_nn not null 
			constraint rhn_sc_sid_fk
				references rhnServer(id),
	channel_id	number
			constraint rhn_sc_cid_nn not null 
			constraint rhn_sc_cid_fk
				references rhnChannel(id),
	created		date default(sysdate)
			constraint rhn_sc_created_nn not null,
	modified	date default(sysdate)
			constraint rhn_sc_modified_nn not null
)
	storage( freelists 16 )
	enable row movement
	initrans 32;

create unique index rhn_sc_sid_cid_uq
	on rhnServerChannel(server_id, channel_id)
	tablespace [[8m_tbs]]
	storage( freelists 16 )
	initrans 32;

create index rhn_sc_cid_sid_idx
	on rhnServerChannel(channel_id, server_id)
	tablespace [[8m_tbs]]
	storage( freelists 16 )
	initrans 32
	nologging;

-- $Log$
-- Revision 1.12  2004/02/09 16:38:38  pjones
-- bugzilla: 115049 -- rework delete_server to be driven from the pl/sql instead
-- of with cascaded deletes
--
-- Revision 1.11  2003/01/30 16:11:28  pjones
-- storage parameters, also fix deps to make it build again
--
-- Revision 1.10  2002/05/10 22:00:48  pjones
-- add rhnFAQClass, and make it a dep for rhnFAQ
-- add grants where appropriate
-- add cvs id/log where it's been missed
-- split data out where appropriate
-- add excludes where appropriate
-- make sure it still builds (at least as sat).
-- (really this time)
--
