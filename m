Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474DB36298D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Apr 2021 22:42:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 071B3100EAB7F;
	Fri, 16 Apr 2021 13:42:18 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 60448100EBB71
	for <linux-nvdimm@lists.01.org>; Fri, 16 Apr 2021 13:42:16 -0700 (PDT)
IronPort-SDR: QtWwVlMklJTj4cJ7QWMTq25XAMgwPDZpL0A9f2+A7GYKWOEQ+B7rgWaWJnjqhg8gaWNLBebzB6
 Y8Ibgm0f832w==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="182601726"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400";
   d="scan'208";a="182601726"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 13:42:14 -0700
IronPort-SDR: VMN/yvwzUAEtqXtPbSENZpWF9mdx/VnKkASKc6KdSzTpPUKbwidcp1r9hmxyqJ1Sj+rfsJZLF9
 YrlZD7ZsNtUQ==
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400";
   d="scan'208";a="400016402"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 13:42:12 -0700
Received: from andy by smile with local (Exim 4.94)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1lXVI2-004l93-3X; Fri, 16 Apr 2021 23:42:10 +0300
Date: Fri, 16 Apr 2021 23:42:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw buffer
Message-ID: <YHn2oiP+2YpkFGXQ@smile.fi.intel.com>
References: <20210415143754.16553-1-andriy.shevchenko@linux.intel.com>
 <YHnLCoeBDn3BcRx1@smile.fi.intel.com>
 <CAPcyv4iwiJwwgiisZTqk6F=A8hLJCGkK-4suqDMPYYiLzuLwFA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4iwiJwwgiisZTqk6F=A8hLJCGkK-4suqDMPYYiLzuLwFA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID-Hash: 7EYIHPSA7QWWPMUR2OSLWDO4CE3VFWWS
X-Message-ID-Hash: 7EYIHPSA7QWWPMUR2OSLWDO4CE3VFWWS
X-MailFrom: andriy.shevchenko@linux.intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Kaneda, Erik" <erik.kaneda@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7EYIHPSA7QWWPMUR2OSLWDO4CE3VFWWS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 16, 2021 at 01:08:06PM -0700, Dan Williams wrote:
> [ add Erik ]
> 
> On Fri, Apr 16, 2021 at 10:36 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Apr 15, 2021 at 05:37:54PM +0300, Andy Shevchenko wrote:
> > > Strictly speaking the comparison between guid_t and raw buffer
> > > is not correct. Return to plain memcmp() since the data structures
> > > haven't changed to use uuid_t / guid_t the current state of affairs
> > > is inconsistent. Either it should be changed altogether or left
> > > as is.
> >
> > Dan, please review this one as well. I think here you may agree with me.
> 
> You know, this is all a problem because ACPICA is using a raw buffer.

And this is fine. It might be any other representation as well.

> Erik, would it be possible to use the guid_t type in ACPICA? That
> would allow NFIT to drop some ugly casts.

guid_t is internal kernel type. If we ever decide to deviate from the current
representation it wouldn't be possible in case a 3rd party is using it 1:1
(via typedef or so).

-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
