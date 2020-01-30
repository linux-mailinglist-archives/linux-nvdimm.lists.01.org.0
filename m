Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2C614E2DF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Jan 2020 20:05:43 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F17721007B1F5;
	Thu, 30 Jan 2020 11:08:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CB02D1007B1F4
	for <linux-nvdimm@lists.01.org>; Thu, 30 Jan 2020 11:08:56 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 11:05:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,382,1574150400";
   d="scan'208";a="222887487"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga008.jf.intel.com with ESMTP; 30 Jan 2020 11:05:34 -0800
Received: from fmsmsx122.amr.corp.intel.com (10.18.125.37) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 30 Jan 2020 11:05:34 -0800
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.143]) by
 fmsmsx122.amr.corp.intel.com ([169.254.5.232]) with mapi id 14.03.0439.000;
 Thu, 30 Jan 2020 11:05:33 -0800
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH] ndctl/lib: make dimm_ops in private.h extern
Thread-Topic: [ndctl PATCH] ndctl/lib: make dimm_ops in private.h extern
Thread-Index: AQHV158JEHnvUTuYw06fHnV9kEDNjqgEFugAgAAAcwA=
Date: Thu, 30 Jan 2020 19:05:32 +0000
Message-ID: <bb6913f28ab3653efda460cee33aebe1c391ae09.camel@intel.com>
References: <20200130185631.29817-1-vishal.l.verma@intel.com>
	 <CAPcyv4hLaLTdDjEhfkYHPCUyeRRSxXu=prG05WZFYtMTo=TFBQ@mail.gmail.com>
In-Reply-To: <CAPcyv4hLaLTdDjEhfkYHPCUyeRRSxXu=prG05WZFYtMTo=TFBQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.232.112.164]
Content-ID: <2A189A5B11E94C46AEAD3879AABEFC31@intel.com>
MIME-Version: 1.0
Message-ID-Hash: JFPQRQG43SZYXAZ2ERL47TM242IDPVTL
X-Message-ID-Hash: JFPQRQG43SZYXAZ2ERL47TM242IDPVTL
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JFPQRQG43SZYXAZ2ERL47TM242IDPVTL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2020-01-30 at 11:03 -0800, Dan Williams wrote:
> On Thu, Jan 30, 2020 at 10:56 AM Vishal Verma <vishal.l.verma@intel.com> wrote:
> > A toolchain update in Fedora 32 caused new compile errors due to
> > multiple definitions of dimm_ops structures. The declarations in
> > 'private.h' for the various NFIT families are present so that libndctl
> > can find all the per-family dimm-ops. However they need to be declared
> > as extern because the actual definitions are in <family>.c
> 
> Looks good to me. Does this quiet the build spew?

I'm testing that now - it at least doesn't introduce any new errors in
my F30 environment and makes sense.

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
