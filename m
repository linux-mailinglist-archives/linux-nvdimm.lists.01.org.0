Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81173E90BB
	for <lists+linux-nvdimm@lfdr.de>; Tue, 29 Oct 2019 21:19:15 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 94D04100EA538;
	Tue, 29 Oct 2019 13:19:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 86C02100EA537
	for <linux-nvdimm@lists.01.org>; Tue, 29 Oct 2019 13:19:52 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 13:19:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,245,1569308400";
   d="scan'208";a="193734011"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga008.jf.intel.com with ESMTP; 29 Oct 2019 13:19:10 -0700
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 29 Oct 2019 13:18:47 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 fmsmsx124.amr.corp.intel.com ([169.254.8.139]) with mapi id 14.03.0439.000;
 Tue, 29 Oct 2019 13:18:47 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH] ndctl/namespace: Fixup man page indentation
Thread-Topic: [ndctl PATCH] ndctl/namespace: Fixup man page indentation
Thread-Index: AQHVjoQz+a7HkFpZn0u/XzrsllVmgqdyhHOA
Date: Tue, 29 Oct 2019 20:18:47 +0000
Message-ID: <96e83e44efe30efd8d599b89b3a117242ab860f2.camel@intel.com>
References: <157237178859.4146560.1913830646961375457.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157237178859.4146560.1913830646961375457.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <5973D0B5AA834F4B8E7DD55A3DE3C171@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 2IT4PZDNE5UPJB2LQDXWBZGPLPK4Z2MQ
X-Message-ID-Hash: 2IT4PZDNE5UPJB2LQDXWBZGPLPK4Z2MQ
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2IT4PZDNE5UPJB2LQDXWBZGPLPK4Z2MQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2019-10-29 at 10:56 -0700, Dan Williams wrote:
> Text that follows a list tends to continue the list indentation. Use a
> bare "::" to end the list indentation.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/ndctl/ndctl-create-namespace.txt |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ndctl/ndctl-create-namespace.txt b/Documentation/ndctl/ndctl-create-namespace.txt
> index 45a4c4c2f408..8cd80fa789c1 100644
> --- a/Documentation/ndctl/ndctl-create-namespace.txt
> +++ b/Documentation/ndctl/ndctl-create-namespace.txt
> @@ -155,7 +155,7 @@ OPTIONS
>  	per-page metadata.  The allocation can be drawn from either:
>  	- "mem": typical system memory
>  	- "dev": persistent memory reserved from the namespace
> -
> +::
>  	Given relative capacities of "Persistent Memory" to "System
>  	RAM" the allocation defaults to reserving space out of the
>  	namespace directly ("--map=dev"). The overhead is 64-bytes per
> 
Good find!

I see how this (ab)uses the list marker by creating a new list item
without a new 'term' associated with it. I disliked creating a new list
item when the paragraph logically belongs in the previous list, and I
tried to use various combinations of list continuation markers, play
around with list starts/ends, but couldn't get the paragraph to
dissociate from the 'dev/mem' sublist and associate it back to the
'parent' list.

So I'll take this :)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
