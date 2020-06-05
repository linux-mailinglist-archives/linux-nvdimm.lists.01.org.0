Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210FA1EEEE0
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jun 2020 02:54:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B7033100A3035;
	Thu,  4 Jun 2020 17:49:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 00784100A3034
	for <linux-nvdimm@lists.01.org>; Thu,  4 Jun 2020 17:49:21 -0700 (PDT)
IronPort-SDR: zOiZN0U9+JWjN1WSXwdKfw9xjzy29NrUIx9W/J4YQBJ65tH825KRidZ4BK7AVBIt2/zw6CcKVt
 c188eu9YxGug==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 17:54:29 -0700
IronPort-SDR: DK9Zg4vUfOtZGtaZS0lVggWKQtwKPeO2C6na0Rzl1HrwsRdpSoTMCR6jSx7p+FTi34mvMjF7QV
 7ooqw+fjgFmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,474,1583222400";
   d="scan'208";a="257888585"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga007.fm.intel.com with ESMTP; 04 Jun 2020 17:54:28 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 4 Jun 2020 17:54:28 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 4 Jun 2020 17:54:27 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 4 Jun 2020 17:54:27 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.56) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 4 Jun 2020 17:54:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEz8QmfDwjk2kQHW2FkhkxLZjF142tOywNsypak8XZVEZfnKHzFPPfdOucMXzVzpDRpgoEdBEfC1c6qXLwlL/UgUc0YzuSj/Zq1zotH1y0DBPXr6LBxHy7q4WoGHl5SiiHEmUev/aXM9RcwPZy/P+IpKVr4IKBntUREFrB+CsOm5Zq7DWLvR8rPFR5GBOjuAASyLhuO/zFGQk2V1h/8VvMdvvf10qYcGdrcFFPf71MGgda822/XQHCyMQZFt9eoC6jdmc2IStKYOJjuoC5LYc3wDKhuZkezpzwBgL8seAB/4WJZQyK5+gzjv+BXiRfqMCoj21Ep4ZsnwkuSiEkDosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KziKsUmUwvUnVWUs0YG6xy5FOjjIRZP4ZrhOIHSYiNg=;
 b=eN0w6YLOfia11OUwra/jiiM7YF7oD3FXwV7F5BF1GflmVi1vyvqjEm0dszS09eZJ6FmFlZ3/LyDm3rfKJZ36sqDm19mSlnUhDCTvaZtTJZL5oW2ML4kOPrMIoZyfXZlVKFMosytZ4l083+pV6CMloiqkS4Co38BK1326KcZZggwPccRf4VKBR1ZStGf4tlOvQslHCGuMBmLz608BqQYHxmkMRFeWhvgLKdSeINffFl1qFyb2rtxj7LldeQ4yTUVDU0VzZ5ZZqUC5m64ePr1hoZAqAxYM65bjCQf02Y96dC+Dj2cekFVyn61+unxlUL0Uapm8Vuzjz8UIednQDufNvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KziKsUmUwvUnVWUs0YG6xy5FOjjIRZP4ZrhOIHSYiNg=;
 b=vf3TF9TWg6B9PuaSl+AHeBRkQi8dQDtutaioA/D9bbUbG5Z6LxY5h1bqJzUfa7kRAwvRIi/qwLQo9+LW93tm1pg3tyCkIYMxEBuWeNolTDHJLxiI7O2YYENQujx9Z8EvcUxdBdqgH9WTISa/d20gkdKgaQul4LIawGN5hClDFR4=
Received: from BN6PR11MB4132.namprd11.prod.outlook.com (2603:10b6:405:81::10)
 by BN6PR11MB4114.namprd11.prod.outlook.com (2603:10b6:405:84::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 00:54:19 +0000
Received: from BN6PR11MB4132.namprd11.prod.outlook.com
 ([fe80::2d67:42cc:d74f:6e4f]) by BN6PR11MB4132.namprd11.prod.outlook.com
 ([fe80::2d67:42cc:d74f:6e4f%7]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 00:54:19 +0000
From: "Williams, Dan J" <dan.j.williams@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RESEND PATCH v9 4/5] ndctl/papr_scm,uapi: Add support for PAPR
 nvdimm specific methods
Thread-Topic: [RESEND PATCH v9 4/5] ndctl/papr_scm,uapi: Add support for PAPR
 nvdimm specific methods
Thread-Index: AQHWOMbZ1F4nAw1F40+DoRTylQ4OI6jHj3YQgACdnQCAAQUpMA==
Date: Fri, 5 Jun 2020 00:54:18 +0000
Message-ID: <BN6PR11MB4132FA66A84CBD798AADCEC1C6860@BN6PR11MB4132.namprd11.prod.outlook.com>
References: <20200602101438.73929-1-vaibhav@linux.ibm.com>
 <20200602101438.73929-5-vaibhav@linux.ibm.com>
 <BN6PR11MB413223B333153721405DFD91C6890@BN6PR11MB4132.namprd11.prod.outlook.com>
 <87h7vrgpzx.fsf@linux.ibm.com>
In-Reply-To: <87h7vrgpzx.fsf@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a562724b-4b6a-47b0-8953-08d808eafa77
x-ms-traffictypediagnostic: BN6PR11MB4114:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB41143714C0F07592AB51E820C6860@BN6PR11MB4114.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7bQlKDKtD1KczrCHeapwb2/yOZJm42yDoX6pRjPRNckp+7P6hJLK5kt8QGN6ZoFmTTV41X8HqNaQR8HfOxM6tmw2U3UhEbYTSjoxok+NfxMCvVKgj6o3FYt7Degsu4k0fY1m8KY2fwwKhmYEc+EcQphcpY6ZpLa9cJ1dME/2HNcYGHQZb20WuwvqT0THggOTjT9K8ej+VVzjdg1OXOr0+jdQDyR3vQgIFe9p8Iw8GGkqVv4W792NFHvrvUba0TcEjUTVLhReDtRkYtDNirivkiZWVX4wL3ZHBDyRNBy69WygBYGUu6ONCu3k4RZKsVqGhLMwitgofJaXtySIkZRIfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4132.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(396003)(39860400002)(136003)(366004)(76116006)(7696005)(6506007)(52536014)(66556008)(186003)(4326008)(66446008)(53546011)(64756008)(26005)(66946007)(107886003)(66476007)(8936002)(86362001)(30864003)(45080400002)(110136005)(5660300002)(55016002)(9686003)(478600001)(33656002)(54906003)(2906002)(8676002)(83380400001)(316002)(71200400001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: sO6Dl3WP5bfAyHw5zrAkrHsHdaeHrGyvTOJhfVO2VUEeQRQM5nsHv0SEy8+p3vOi4Sr7Oxc0xHxWYcj+kR2DADhFSdRK4nXf2Hsn/6hyOG7H1xUlMUFl+GCkiEByBLKpIR+W7gu2EtOOC9nokpGjtDw8iYVauItLxsqOStEMlnaZdWO9LDiIHZ+jYAZGDNhdMgcozWGugBQFusV9LquLHfvOelftG0SIGDtwkpYSNkyTDfYT/29MZTGGcAoKxJtvVcvI+0fZms2v/ugUD6HxDyInSk/OYIp4vzbVC+C8BiNRqSRr7vEwowvpvEjwVvj/RKXet/PaJYDGTAwUJ6Ogr53w5MRoJF/Vyg6iEW4IgLqKGUq9O93UJ1vENNiZwOYnLPVdPtramFhAsd578RTDIxqWFkMAHLSDMPJElpi25FSlE3yPwEN7tJvNuWYlArGuyIyWhoe71ZM45Acv8XcR5dQmHeBD5Bkj9TrRMWVnHopFFjFUm7VjtBHhB2qZwKsV
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a562724b-4b6a-47b0-8953-08d808eafa77
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 00:54:18.8243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06+Fmbq5595x64RDWLps1qER9tVT4Ue3u6EhlQqfCIVTVuilSAtuG/kE92itZEjRPTYhkOntxsww/nCa1yTWqsifmWMbm1FLkMJnWlsGe3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4114
X-OriginatorOrg: intel.com
Message-ID-Hash: VO44CNVGTZ42AK7QQGJJQV6K7AMX2J3W
X-Message-ID-Hash: VO44CNVGTZ42AK7QQGJJQV6K7AMX2J3W
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Oliver@ml01.01.org,
	Ira@ml01.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VO44CNVGTZ42AK7QQGJJQV6K7AMX2J3W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Vaibhav Jain <vaibhav@linux.ibm.com>
> Sent: Thursday, June 4, 2020 2:06 AM
> To: Williams, Dan J <dan.j.williams@intel.com>; linuxppc-
> dev@lists.ozlabs.org; linux-nvdimm@lists.01.org; linux-
> kernel@vger.kernel.org
> Cc: Santosh Sivaraj <santosh@fossix.org>; Aneesh Kumar K . V
> <aneesh.kumar@linux.ibm.com>; Steven Rostedt <rostedt@goodmis.org>;
> Oliver O'Halloran <oohall@gmail.com>; Weiny, Ira <ira.weiny@intel.com>
> Subject: RE: [RESEND PATCH v9 4/5] ndctl/papr_scm,uapi: Add support for
> PAPR nvdimm specific methods
> 
> Hi Dan,
> 
> Thanks for review and insights on this. My responses below:
> 
> "Williams, Dan J" <dan.j.williams@intel.com> writes:
> 
> > [ forgive formatting I'm temporarily stuck using Outlook this week...
> > ]
> >
> >> From: Vaibhav Jain <vaibhav@linux.ibm.com>
> > [..]
> >>
> >> Introduce support for PAPR NVDIMM Specific Methods (PDSM) in
> papr_scm
> >> module and add the command family NVDIMM_FAMILY_PAPR to the
> white
> >> list of NVDIMM command sets. Also advertise support for ND_CMD_CALL
> >> for the nvdimm command mask and implement necessary scaffolding in
> >> the module to handle ND_CMD_CALL ioctl and PDSM requests that we
> receive.
> >>
> >> The layout of the PDSM request as we expect from libnvdimm/libndctl
> >> is described in newly introduced uapi header 'papr_pdsm.h' which
> >> defines a new 'struct nd_pdsm_cmd_pkg' header. This header is used to
> >> communicate the PDSM request via member
> 'nd_cmd_pkg.nd_command' and
> >> size of payload that need to be sent/received for servicing the PDSM.
> >>
> >> A new function is_cmd_valid() is implemented that reads the args to
> >> papr_scm_ndctl() and performs sanity tests on them. A new function
> >> papr_scm_service_pdsm() is introduced and is called from
> >> papr_scm_ndctl() in case of a PDSM request is received via
> >> ND_CMD_CALL command from libnvdimm.
> >>
> >> Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
> >> Cc: Dan Williams <dan.j.williams@intel.com>
> >> Cc: Michael Ellerman <mpe@ellerman.id.au>
> >> Cc: Ira Weiny <ira.weiny@intel.com>
> >> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> >> ---
> >> Changelog:
> >>
> >> Resend:
> >> * Added ack from Aneesh.
> >>
> >> v8..v9:
> >> * Reduced the usage of term SCM replacing it with appropriate
> >>   replacement [ Dan Williams, Aneesh ]
> >> * Renamed 'papr_scm_pdsm.h' to 'papr_pdsm.h'
> >> * s/PAPR_SCM_PDSM_*/PAPR_PDSM_*/g
> >> * s/NVDIMM_FAMILY_PAPR_SCM/NVDIMM_FAMILY_PAPR/g
> >> * Minor updates to 'papr_psdm.h' to replace usage of term 'SCM'.
> >> * Minor update to patch description.
> >>
> >> v7..v8:
> >> * Removed the 'payload_offset' field from 'struct
> >>   nd_pdsm_cmd_pkg'. Instead command payload is always assumed to
> start
> >>   at 'nd_pdsm_cmd_pkg.payload'. [ Aneesh ]
> >> * To enable introducing new fields to 'struct nd_pdsm_cmd_pkg',
> >>   'reserved' field of 10-bytes is introduced. [ Aneesh ]
> >> * Fixed a typo in "Backward Compatibility" section of papr_scm_pdsm.h
> >>   [ Ira ]
> >>
> >> Resend:
> >> * None
> >>
> >> v6..v7 :
> >> * Removed the re-definitions of __packed macro from papr_scm_pdsm.h
> >>   [Mpe].
> >> * Removed the usage of __KERNEL__ macros in papr_scm_pdsm.h
> [Mpe].
> >> * Removed macros that were unused in papr_scm.c from
> papr_scm_pdsm.h
> >>   [Mpe].
> >> * Made functions defined in papr_scm_pdsm.h as static inline. [Mpe]
> >>
> >> v5..v6 :
> >> * Changed the usage of the term DSM to PDSM to distinguish it from the
> >>   ACPI term [ Dan Williams ]
> >> * Renamed papr_scm_dsm.h to papr_scm_pdsm.h and updated various
> >> struct
> >>   to reflect the new terminology.
> >> * Updated the patch description and title to reflect the new terminology.
> >> * Squashed patch to introduce new command family in 'ndctl.h' with
> >>   this patch [ Dan Williams ]
> >> * Updated the papr_scm_pdsm method starting index from 0x10000 to
> 0x0
> >>   [ Dan Williams ]
> >> * Removed redundant license text from the papr_scm_psdm.h file.
> >>   [ Dan Williams ]
> >> * s/envelop/envelope/ at various places [ Dan Williams ]
> >> * Added '__packed' attribute to command package header to gaurd
> >>   against different compiler adding paddings between the fields.
> >>   [ Dan Williams]
> >> * Converted various pr_debug to dev_debug [ Dan Williams ]
> >>
> >> v4..v5 :
> >> * None
> >>
> >> v3..v4 :
> >> * None
> >>
> >> v2..v3 :
> >> * Updated the patch prefix to 'ndctl/uapi' [Aneesh]
> >>
> >> v1..v2 :
> >> * None
> >> ---
> >>  arch/powerpc/include/uapi/asm/papr_pdsm.h | 136
> >> ++++++++++++++++++++++
> arch/powerpc/platforms/pseries/papr_scm.c |
> >> 101 +++++++++++++++-
> >>  include/uapi/linux/ndctl.h                |   1 +
> >>  3 files changed, 232 insertions(+), 6 deletions(-)  create mode
> >> 100644 arch/powerpc/include/uapi/asm/papr_pdsm.h
> >>
> >> diff --git a/arch/powerpc/include/uapi/asm/papr_pdsm.h
> >> b/arch/powerpc/include/uapi/asm/papr_pdsm.h
> >> new file mode 100644
> >> index 000000000000..6407fefcc007
> >> --- /dev/null
> >> +++ b/arch/powerpc/include/uapi/asm/papr_pdsm.h
> >> @@ -0,0 +1,136 @@
> >> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> >> +/*
> >> + * PAPR nvDimm Specific Methods (PDSM) and structs for libndctl
> >> + *
> >> + * (C) Copyright IBM 2020
> >> + *
> >> + * Author: Vaibhav Jain <vaibhav at linux.ibm.com>  */
> >> +
> >> +#ifndef _UAPI_ASM_POWERPC_PAPR_PDSM_H_ #define
> >> +_UAPI_ASM_POWERPC_PAPR_PDSM_H_
> >> +
> >> +#include <linux/types.h>
> >> +
> >> +/*
> >> + * PDSM Envelope:
> >> + *
> >> + * The ioctl ND_CMD_CALL transfers data between user-space and
> >> +kernel via
> >> + * envelope which consists of a header and user-defined payload
> sections.
> >> + * The header is described by 'struct nd_pdsm_cmd_pkg' which expects
> >> +a
> >> + * payload following it and accessible via 'nd_pdsm_cmd_pkg.payload'
> field.
> >> + * There is reserved field that can used to introduce new fields to
> >> +the
> >> + * structure in future. It also tries to ensure that
> >> 'nd_pdsm_cmd_pkg.payload'
> >> + * lies at a 8-byte boundary.
> >> + *
> >> + *  +-------------+---------------------+---------------------------+
> >> + *  |   64-Bytes  |       16-Bytes      |       Max 176-Bytes       |
> >> + *  +-------------+---------------------+---------------------------+
> >> + *  |               nd_pdsm_cmd_pkg     |                           |
> >> + *  |-------------+                     |                           |
> >> + *  |  nd_cmd_pkg |                     |                           |
> >> + *  +-------------+---------------------+---------------------------+
> >> + *  | nd_family   |                     |                           |
> >> + *  | nd_size_out | cmd_status          |                           |
> >> + *  | nd_size_in  | payload_version     |     payload               |
> >> + *  | nd_command  | reserved            |                           |
> >> + *  | nd_fw_size  |                     |                           |
> >> + *
> >> + +-------------+---------------------+---------------------------+
> >> + *
> >> + * PDSM Header:
> >> + *
> >> + * The header is defined as 'struct nd_pdsm_cmd_pkg' which embeds a
> >> + * 'struct nd_cmd_pkg' instance. The PDSM command is assigned to
> >> member
> >> + * 'nd_cmd_pkg.nd_command'. Apart from size information of the
> >> envelope
> >> +which is
> >> + * contained in 'struct nd_cmd_pkg', the header also has members
> >> +following
> >> + * members:
> >> + *
> >> + * 'cmd_status'		: (Out) Errors if any encountered while
> >> servicing PDSM.
> >> + * 'payload_version'	: (In/Out) Version number associated with
> the
> >> payload.
> >> + * 'reserved'		: Not used and reserved for future.
> >> + *
> >> + * PDSM Payload:
> >> + *
> >> + * The layout of the PDSM Payload is defined by various structs
> >> +shared between
> >> + * papr_scm and libndctl so that contents of payload can be
> >> +interpreted. During
> >> + * servicing of a PDSM the papr_scm module will read input args from
> >> +the payload
> >> + * field by casting its contents to an appropriate struct pointer
> >> +based on the
> >> + * PDSM command. Similarly the output of servicing the PDSM command
> >> +will be
> >> + * copied to the payload field using the same struct.
> >> + *
> >> + * 'libnvdimm' enforces a hard limit of 256 bytes on the envelope
> >> +size, which
> >> + * leaves around 176 bytes for the envelope payload (ignoring any
> >> +padding that
> >> + * the compiler may silently introduce).
> >> + *
> >> + * Payload Version:
> >> + *
> >> + * A 'payload_version' field is present in PDSM header that
> >> +indicates a specific
> >> + * version of the structure present in PDSM Payload for a given PDSM
> >> command.
> >> + * This provides backward compatibility in case the PDSM Payload
> >> +structure
> >> + * evolves and different structures are supported by 'papr_scm' and
> >> 'libndctl'.
> >> + *
> >> + * When sending a PDSM Payload to 'papr_scm', 'libndctl' should send
> >> +the version
> >> + * of the payload struct it supports via 'payload_version' field.
> >> +The
> >> 'papr_scm'
> >> + * module when servicing the PDSM envelope checks the
> 'payload_version'
> >> +and then
> >> + * uses 'payload struct version' == MIN('payload_version field',
> >> + * 'max payload-struct-version supported by papr_scm') to service
> >> +the
> >> PDSM.
> >> + * After servicing the PDSM, 'papr_scm' put the negotiated version
> >> +of payload
> >> + * struct in returned 'payload_version' field.
> >> + *
> >> + * Libndctl on receiving the envelope back from papr_scm again
> >> +checks the
> >> + * 'payload_version' field and based on it use the appropriate
> >> +version dsm
> >> + * struct to parse the results.
> >> + *
> >> + * Backward Compatibility:
> >> + *
> >> + * Above scheme of exchanging different versioned PDSM struct
> >> +between libndctl
> >> + * and papr_scm should provide backward compatibility until
> >> +following two
> >> + * assumptions/conditions when defining new PDSM structs hold:
> >> + *
> >> + * Let T(X) = { set of attributes in PDSM struct 'T' versioned X }
> >> + *
> >> + * 1. T(X) is a proper subset of T(Y) if Y > X.
> >> + *    i.e Each new version of PDSM struct should retain existing struct
> >> + *    attributes from previous version
> >> + *
> >> + * 2. If an entity (libndctl or papr_scm) supports a PDSM struct T(X) then
> >> + *    it should also support T(1), T(2)...T(X - 1).
> >> + *    i.e When adding support for new version of a PDSM struct, libndctl
> >> + *    and papr_scm should retain support of the existing PDSM struct
> >> + *    version they support.
> >> + */
> >> +
> >> +/* PDSM-header + payload expected with ND_CMD_CALL ioctl from
> >> libnvdimm
> >> +*/ struct nd_pdsm_cmd_pkg {
> >> +	struct nd_cmd_pkg hdr;	/* Package header containing sub-
> >> cmd */
> >> +	__s32 cmd_status;	/* Out: Sub-cmd status returned back */
> >> +	__u16 reserved[5];	/* Ignored and to be used in future */
> >> +	__u16 payload_version;	/* In/Out: version of the payload */
> >> +	__u8 payload[];		/* In/Out: Sub-cmd data buffer */
> >> +} __packed;
> >> +
> >> +/*
> >> + * Methods to be embedded in ND_CMD_CALL request. These are sent
> to
> >> the
> >> +kernel
> >> + * via 'nd_pdsm_cmd_pkg.hdr.nd_command' member of the ioctl struct
> >> +*/ enum papr_pdsm {
> >> +	PAPR_PDSM_MIN = 0x0,
> >> +	PAPR_PDSM_MAX,
> >> +};
> >> +
> >> +/* Convert a libnvdimm nd_cmd_pkg to pdsm specific pkg */ static
> >> +inline struct nd_pdsm_cmd_pkg *nd_to_pdsm_cmd_pkg(struct
> nd_cmd_pkg
> >> *cmd) {
> >> +	return (struct nd_pdsm_cmd_pkg *) cmd; }
> >> +
> >> +/* Return the payload pointer for a given pcmd */ static inline void
> >> +*pdsm_cmd_to_payload(struct nd_pdsm_cmd_pkg *pcmd) {
> >> +	if (pcmd->hdr.nd_size_in == 0 && pcmd->hdr.nd_size_out == 0)
> >> +		return NULL;
> >> +	else
> >> +		return (void *)(pcmd->payload);
> >> +}
> >> +
> >> +#endif /* _UAPI_ASM_POWERPC_PAPR_PDSM_H_ */
> >> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c
> >> b/arch/powerpc/platforms/pseries/papr_scm.c
> >> index 149431594839..5e2237e7ec08 100644
> >> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> >> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> >> @@ -15,13 +15,15 @@
> >>  #include <linux/seq_buf.h>
> >>
> >>  #include <asm/plpar_wrappers.h>
> >> +#include <asm/papr_pdsm.h>
> >>
> >>  #define BIND_ANY_ADDR (~0ul)
> >>
> >>  #define PAPR_SCM_DIMM_CMD_MASK \
> >>  	((1ul << ND_CMD_GET_CONFIG_SIZE) | \
> >>  	 (1ul << ND_CMD_GET_CONFIG_DATA) | \
> >> -	 (1ul << ND_CMD_SET_CONFIG_DATA))
> >> +	 (1ul << ND_CMD_SET_CONFIG_DATA) | \
> >> +	 (1ul << ND_CMD_CALL))
> >>
> >>  /* DIMM health bitmap bitmap indicators */
> >>  /* SCM device is unable to persist memory contents */ @@ -350,16
> >> +352,97 @@ static int papr_scm_meta_set(struct papr_scm_priv *p,
> >>  	return 0;
> >>  }
> >>
> >> +/*
> >> + * Validate the inputs args to dimm-control function and return '0' if valid.
> >> + * This also does initial sanity validation to ND_CMD_CALL
> >> +sub-command
> >> packages.
> >> + */
> >> +static int is_cmd_valid(struct nvdimm *nvdimm, unsigned int cmd,
> >> +void
> >> *buf,
> >> +		       unsigned int buf_len)
> >> +{
> >> +	unsigned long cmd_mask = PAPR_SCM_DIMM_CMD_MASK;
> >> +	struct nd_pdsm_cmd_pkg *pkg = nd_to_pdsm_cmd_pkg(buf);
> >> +	struct papr_scm_priv *p;
> >> +
> >> +	/* Only dimm-specific calls are supported atm */
> >> +	if (!nvdimm)
> >> +		return -EINVAL;
> >> +
> >> +	/* get the provider date from struct nvdimm */
> >> +	p = nvdimm_provider_data(nvdimm);
> >> +
> >> +	if (!test_bit(cmd, &cmd_mask)) {
> >> +		dev_dbg(&p->pdev->dev, "Unsupported cmd=%u\n", cmd);
> >> +		return -EINVAL;
> >> +	} else if (cmd == ND_CMD_CALL) {
> >> +
> >> +		/* Verify the envelope package */
> >> +		if (!buf || buf_len < sizeof(struct nd_pdsm_cmd_pkg)) {
> >> +			dev_dbg(&p->pdev->dev, "Invalid pkg size=%u\n",
> >> +				buf_len);
> >> +			return -EINVAL;
> >> +		}
> >> +
> >> +		/* Verify that the PDSM family is valid */
> >> +		if (pkg->hdr.nd_family != NVDIMM_FAMILY_PAPR) {
> >> +			dev_dbg(&p->pdev->dev, "Invalid pkg
> >> family=0x%llx\n",
> >> +				pkg->hdr.nd_family);
> >> +			return -EINVAL;
> >> +
> >> +		}
> >> +
> >> +		/* We except a payload with all PDSM commands */
> >> +		if (pdsm_cmd_to_payload(pkg) == NULL) {
> >> +			dev_dbg(&p->pdev->dev,
> >> +				"Empty payload for sub-command=0x%llx\n",
> >> +				pkg->hdr.nd_command);
> >> +			return -EINVAL;
> >> +		}
> >> +	}
> >> +
> >> +	/* Command looks valid */
> >
> <snip>
> > So this is where I would expect the kernel to validate the command vs
> > a known list of supported commands / payloads. One of the goals of
> > requiring public documentation of any commands that libnvdimm might
> > support for the ioctl path is to give the kernel the ability to gate
> > future enabling on consideration of a common kernel front-end
> > interface. I believe this would also address questions about the
> > versioning scheme because userspace would be actively prevented from
> > sending command payloads that were not first explicitly enabled in the
> > kernel. This interface as it stands in this patch set seems to be a
> > very thin / "anything goes" passthrough with no consideration for that
> > policy.
> >
> > As an example of the utility of this policy, consider the recent
> > support for nvdimm security commands that allow a passphrase to be set
> > and issue commands like "unlock" and "secure erase". The kernel
> > actively prevents those commands from being sent from userspace. See
> > acpi_nfit_clear_to_send() and nd_cmd_clear_to_send(). The reasoning is
> > that it enforces the kernel's nvdimm security model that uses
> > encrypted/trusted keys to protect key material (clear text keys
> > only-ever exist in kernel-space). Yes, that restriction is painful for
> > people that don't want the kernel's security model and just want the
> > simplicity of passing clear-text keys around, but it's necessary for
> > the kernel to have any chance to provide a common abstraction across
> > vendors. The pain of negotiating every single command with what the
> > kernel will support is useful for the long term health of the kernel.
> > It forces ongoing conversations across vendors to consolidate
> > interfaces and reuse kernel best practices like encrypted/trusted
> > keys. Code acceptance is the only real gate the kernel has to enforce
> > cooperation across vendors.
> >
> > The expectation is that the kernel does not allow any command to pass
> > that is not explicitly listed in a bitmap of known commands. I would
> > expect that if you changed the payload of an existing command that
> > would likely require a new entry in this bitmap. The goal is to give
> > the kernel a chance to constrain the passthrough interface to afford a
> > chance to have a discussion of what might done in a common
> > implementation. Another example is the label-area read-write commands.
> > The kernel needs explicit control to ensure that it owns the label
> > area and that userspace is not able to corrupt it (write it behind the
> > kernel's back).
> >
> > Now that said, I have battle scars with some OEMs that just want a
> > generic passthrough interface so they never need to work with the
> > kernel community again and can just write their custom validation
> > tooling and be done. I've mostly been successful in that fight outside
> > of the gaping hole of ND_CMD_VENDOR. That's the path that ipmctl has
> > used to issue commands that have not made it into the public
> > specification on docs.pmem.io. My warning shot for that is the
> > "disable_vendor_specific" module option that administrators can set to
> > only allow commands that the kernel explicitly knows the effects of to
> > be issued. The result is only tooling / enabling that submits to this
> > auditing regime is guaranteed to work everywhere.
> 
> Agree with points made above. With this patchset we arent really trying to
> push an ioctl passthrough to exchange arbitary data with papr-scm module.
> Nor do we want to bypass the kernel community for any future
> enhancements on this interface. We made some design choices based on
> our understanding of certain restriction we saw in ndctl/libndctl. Specifically
> wanted to avoid issuing two CMD_CALL ioctl roundtrips.
> 
> That being said I had an extended discussion with Aneesh rethinking the
> 'version' field and we both agreed *to remove this field* from the proposed
> 'struct nd_pdsm_cmd_pkg'. This should resolve the contentions around this
> Patch-4 in this patchset. Since the 'version' field isnt extensively used right
> now the impact on the patchset would be small.
> 
> >
> > So, that long explanation out of the way, what does that mean for this
> > patch set? I'd like to understand if you still see a need for a
> > versioning scheme if the implementation is required to explicitly list
> > all the commands it supports? I.e. that the kernel need not worry
> > about userspace sending future unknown payloads because unknown
> > payloads are blocked. Also if your interface has anything similar to a
> > "vendor specific" passthrough I would like to require that go through
> > the ND_CMD_VENDOR ioctl, so that the kernel still has a common check
> > point to prevent vendor specific "I don't want to talk to the kernel
> > community" shenanigans, but even better if ND_CMD_VENDOR is
> something
> > the kernel can eventually jettison because nobody is using it.
> 
> As I mentioned above this isn't a 'vendor specific passthrough'
> machenism. The 'version' field was proposed to avoid two CMD_CALL ioctl
> roundtrip to fetch and report extended nvdimm health data like 'life-
> remaining' which isnt always available for papr-scm.

Oh, why not define a maximal health payload with all the attributes you know about today, leave some room for future expansion, and then report a validity flag for each attribute? This is how the "intel" smart-health payload works. If they ever needed to extend the payload they would increase the size and add more validity flags. Old userspace never groks the new fields, new userspace knows to ask for and parse the larger payload.

See the flags field in 'struct nd_intel_smart' (in ndctl) and the translation of those flags to ndctl generic attribute flags intel_cmd_smart_get_flags().

In general I'd like ndctl to understand the superset of all health attributes across all vendors. For the truly vendor specific ones it would mean that the health flags with a specific "papr_scm" back-end just would never be set on an "intel" device. I.e. look at the "hpe" and "msft" health backends. They only set a subset of the valid flags that could be reported.

> However we just realized instead of relying on 'version' field we can
> advertise support for these extended attributes via nvdimm-flags from sysfs.
> Looking at the nvdimm-flags libndctl can use an appropriate pdsm command
> and struct to fetch the dimm health information from papr_scm via
> CMD_CALL.
> 
> But thats something we plan to do in future and not with the current
> patchset which only reports fixed set of nvdimm health attributes.
> 
> >
> > I feel like this is a conversation that will take a few days to
> > resolve, which does not leave time to push this for v5.8. That said, I
> > do think the health flags patches at the beginning of this series are
> > low risk and uncontentious. How about I merge those for v5.8 and
> > circle back to get this ioctl path queued early in v5.8-rc? Apologies
> > for the late feedback on this relative to v5.8.
> >
> Thanks for this consideration. Agree to the proposal. However changes to
> patchset with removal of 'version' field is fairly small hence can quickly push
> an updated patch series cumulating rest of the review comments from Ira.
> 
> Does that sounds reasonable ?

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
