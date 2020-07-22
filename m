Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41107228F5A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 22 Jul 2020 06:45:27 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 30E4612469902;
	Tue, 21 Jul 2020 21:45:25 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E159B12469901
	for <linux-nvdimm@lists.01.org>; Tue, 21 Jul 2020 21:45:22 -0700 (PDT)
IronPort-SDR: FtvxHBa1Y1p6VbGngOKtr+D9kzuaXo8+oq39Nlj6JmMCAkx3OMrFSyXUjJGT8X9svd/jMkBsMY
 xsYxTADmnBeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="149435662"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800";
   d="scan'208";a="149435662"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 21:45:22 -0700
IronPort-SDR: dTZaca5gqBEnMshBaTDm+KlMp5tKubeAcLckzpdS8V9wjLpFNqcgDJqSCxhpHe/UHg25f8PwuK
 zSClX8xZRJOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800";
   d="scan'208";a="288158076"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga006.jf.intel.com with ESMTP; 21 Jul 2020 21:45:21 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.122]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.31]) with mapi id 14.03.0439.000;
 Tue, 21 Jul 2020 21:45:21 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"vaibhav@linux.ibm.com" <vaibhav@linux.ibm.com>
Subject: Re: [ndctl PATCH] papr: Check for command type in
 papr_xlat_firmware_status()
Thread-Topic: [ndctl PATCH] papr: Check for command type in
 papr_xlat_firmware_status()
Thread-Index: AQHWX1QtWD/9JPRT9USLRwbL3cJ+9KkSa2OAgADi34CAAC48AA==
Date: Wed, 22 Jul 2020 04:45:21 +0000
Message-ID: <c01b0d7a3c54245b02c76d48c806e9423fe1d8d8.camel@intel.com>
References: <20200721114326.305790-1-vaibhav@linux.ibm.com>
	 <3a1ed55273a2c901228f5f6bc1824707a70d6dcb.camel@intel.com>
	 <87pn8o48dk.fsf@linux.ibm.com>
In-Reply-To: <87pn8o48dk.fsf@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.255.75.30]
Content-ID: <253FA0BC1AD0AB409BDC1DC63D95CA46@intel.com>
MIME-Version: 1.0
Message-ID-Hash: MEIA7N3Q65LJZQGF7N7N4HASUGZ7TJYF
X-Message-ID-Hash: MEIA7N3Q65LJZQGF7N7N4HASUGZ7TJYF
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MEIA7N3Q65LJZQGF7N7N4HASUGZ7TJYF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2020-07-22 at 07:29 +0530, Vaibhav Jain wrote:
> Vishal Verma <vishal.l.verma@intel.com> writes:
> 
> <snip>
> > >  static int papr_xlat_firmware_status(struct ndctl_cmd *cmd)
> > >  {
> > > -	const struct nd_pkg_pdsm *pcmd = to_pdsm(cmd);
> > > -
> > > -	return pcmd->cmd_status;
> > > +	return (cmd->type == ND_CMD_CALL) ? to_pdsm(cmd)->cmd_status :
> > > 0;
> > 
> > Is this correct? -- for non ND_CMD_CALL commands this will always
> > return a 0,
> > and it seems like you will lose any error state for commands
> > like ND_CMD_SET_CONFIG_DATA.
> This behaviour is similar to what ndctl_cmd_xlat_firmware_status()
> does
> when corresponding dimm-ops are missing the 'xlat_firmware_status'
> callback.
> 
> Also ndctl_cmd_submit_xlat() returns the rc from ndctl_cmd_submit()
> in case ndctl_cmd_xlat_firmware_status() returns '0', which
> corresponds
> to 'ndctl_cmd.status' field. So any error codes
> returned from ndctl_cmd_submit() are still returned back to the caller
> even though papr_xlat_firmware_status() returned '0'. 

Ah yes you're right. I'll queue this up for v69 and we can do the more
involved fix in the next cycle.

Thanks!
-Vishal
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
