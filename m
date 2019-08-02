Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9967C7FFF7
	for <lists+linux-nvdimm@lfdr.de>; Fri,  2 Aug 2019 20:01:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8DB122130C4BB;
	Fri,  2 Aug 2019 11:04:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B005E213030AC
 for <linux-nvdimm@lists.01.org>; Fri,  2 Aug 2019 11:04:26 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Aug 2019 11:01:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,339,1559545200"; d="scan'208";a="373028504"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga006.fm.intel.com with ESMTP; 02 Aug 2019 11:01:55 -0700
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 2 Aug 2019 11:01:55 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.180]) by
 FMSMSX154.amr.corp.intel.com ([169.254.6.214]) with mapi id 14.03.0439.000;
 Fri, 2 Aug 2019 11:01:55 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-nvdimm@lists.01.org"
 <linux-nvdimm@lists.01.org>
Subject: Re: [ndctl PATCH v2 01/26] ndctl/dimm: Add 'flags' field to
 read-labels output
Thread-Topic: [ndctl PATCH v2 01/26] ndctl/dimm: Add 'flags' field to
 read-labels output
Thread-Index: AQHVRMXFk8hZoXumUUC7YlpdpdBIPKbopIeA
Date: Fri, 2 Aug 2019 18:01:54 +0000
Message-ID: <c6026e16692b0aae2b8fdef1085940259d40de93.camel@intel.com>
References: <156426356088.531577.14828880045306313118.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156426356654.531577.6142389862764297120.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156426356654.531577.6142389862764297120.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <ED9ACBD02DB85A49A60B36F2F66C12ED@intel.com>
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


On Sat, 2019-07-27 at 14:39 -0700, Dan Williams wrote:
> Recent discussions on some platform implementations setting the LOCAL
> bit in namespace labels makes it apparent that this field should be
> decoded in the json representation.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  ndctl/dimm.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/ndctl/dimm.c b/ndctl/dimm.c
> index b2b09b6aa9a2..8946dc74fe41 100644
> --- a/ndctl/dimm.c
> +++ b/ndctl/dimm.c
> @@ -141,6 +141,11 @@ static struct json_object *dump_label_json(struct ndctl_dimm *dimm,
>  			break;
>  		json_object_object_add(jlabel, "nlabel", jobj);
>  
> +		jobj = json_object_new_int64(le64_to_cpu(nslabel.flags));

Should we print this in hex instead?

> +		if (!jobj)
> +			break;
> +		json_object_object_add(jlabel, "flags", jobj);
> +
>  		jobj = json_object_new_int64(le64_to_cpu(nslabel.isetcookie));
>  		if (!jobj)
>  			break;
> 

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
