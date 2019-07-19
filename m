Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0CF6EA7F
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Jul 2019 20:08:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1FCF7212D2771;
	Fri, 19 Jul 2019 11:10:49 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8B7B7212BF9B3
 for <linux-nvdimm@lists.01.org>; Fri, 19 Jul 2019 11:10:46 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Jul 2019 11:08:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,283,1559545200"; d="scan'208";a="367339049"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by fmsmga005.fm.intel.com with ESMTP; 19 Jul 2019 11:08:19 -0700
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 19 Jul 2019 11:08:19 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.252]) by
 fmsmsx163.amr.corp.intel.com ([169.254.6.210]) with mapi id 14.03.0439.000;
 Fri, 19 Jul 2019 11:08:19 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH v6 05/13] daxctl/list: add target_node for device
 listings
Thread-Topic: [ndctl PATCH v6 05/13] daxctl/list: add target_node for device
 listings
Thread-Index: AQHVPPKMprXruz8DyE+YHo71BDtVeabRgAKAgAE1UoA=
Date: Fri, 19 Jul 2019 18:08:18 +0000
Message-ID: <b86f69b2b0e7b3f3755c64f7a4310161dc8389dc.camel@intel.com>
References: <20190717225400.9494-1-vishal.l.verma@intel.com>
 <20190717225400.9494-6-vishal.l.verma@intel.com>
 <CAPcyv4jeVMQP8QAtiQt81n1+jS7J49L8Ki_GDtT6rXFmaxMogQ@mail.gmail.com>
In-Reply-To: <CAPcyv4jeVMQP8QAtiQt81n1+jS7J49L8Ki_GDtT6rXFmaxMogQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <8DF20C0B9CA2904DB3B0C56C720F7C6E@intel.com>
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
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, 2019-07-18 at 16:41 -0700, Dan Williams wrote:
> On Wed, Jul 17, 2019 at 3:54 PM Vishal Verma <vishal.l.verma@intel.com
> > wrote:
> > 
> > @@ -284,6 +285,13 @@ struct json_object
> > *util_daxctl_dev_to_json(struct daxctl_dev *dev,
> >         if (jobj)
> >                 json_object_object_add(jdev, "size", jobj);
> > 
> > +       node = daxctl_dev_get_target_node(dev);
> > +       if (node >= 0) {
> > +               jobj = json_object_new_int(node);
> > +               if (jobj)
> > +                       json_object_object_add(jdev, "target_node",
> > jobj);
> > +       }
> > +
> 
> We moved 'numa_node' to the UTIL_JSON_VERBOSE set on "ndctl list"
> should do the same for target node?

Hm, true. Arguably, the target_node is much more pertinent in system-ram 
mode, and /should/ be in the default verbosity?

One option could be to make it always show if the mode is system-ram,
but not otherwise - but I don't know if that would cause more confusion
as an attribute might seem to magically appear or disappear with the
same command options..

Yet another option is, the output right after daxctl-reconfigure-device
always sets UTIL_JSON_VERBOSE, but for daxctl-list, it is only done if
the user supplies it.

Any preferences on which way to go?

Thanks,
-Vishal
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
