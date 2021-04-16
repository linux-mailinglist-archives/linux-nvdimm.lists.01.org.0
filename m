Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC343626E4
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Apr 2021 19:34:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CAE62100EAB64;
	Fri, 16 Apr 2021 10:34:06 -0700 (PDT)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=andy.shevchenko@gmail.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1585E100EC1CE
	for <linux-nvdimm@lists.01.org>; Fri, 16 Apr 2021 10:34:03 -0700 (PDT)
IronPort-SDR: RjNjenYLQgHytLfIC/qinaWkn9QS5uufXS/Q5bSLiavhQMLn2/b/ejyjyQnpqvHAJGzq7MH2Vp
 0uj5/O3Wtctw==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="195187178"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400";
   d="scan'208";a="195187178"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 10:34:00 -0700
IronPort-SDR: tQrUzqzEe3V356yqOX8dVKzGb6oKF+Dpyp4L/dGsykNQFKvpC6rCseUSSOQKMjSHKIaMDLo+Fk
 6DHuR+ZeKZYA==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400";
   d="scan'208";a="425668212"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 10:33:58 -0700
Received: from andy by smile with local (Exim 4.94)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1lXSLr-004iQM-GJ; Fri, 16 Apr 2021 20:33:55 +0300
Date: Fri, 16 Apr 2021 20:33:55 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Import GUID before use
Message-ID: <YHnKg4MHkZ4QIBHR@smile.fi.intel.com>
References: <20210415135901.47131-1-andriy.shevchenko@linux.intel.com>
 <CAPcyv4jpkZNsQEvCe_dLoq0DOTrEX36vhkJg+zqEacUkJtvWiQ@mail.gmail.com>
 <CAHp75VcpQREYFesS9q2TeqrR29hf0CvMESM42AVGAFzEYeRr_Q@mail.gmail.com>
 <CAPcyv4jzg23CoQeqAyAR=PUjB4HG-FSnD8G0J7S=p22ANmzDMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4jzg23CoQeqAyAR=PUjB4HG-FSnD8G0J7S=p22ANmzDMQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID-Hash: 5U6T62RKINS3XQLEI2Q5N62XHPMFE5KK
X-Message-ID-Hash: 5U6T62RKINS3XQLEI2Q5N62XHPMFE5KK
X-MailFrom: andy.shevchenko@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5U6T62RKINS3XQLEI2Q5N62XHPMFE5KK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 16, 2021 at 09:15:34AM -0700, Dan Williams wrote:
> On Fri, Apr 16, 2021 at 1:58 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Apr 16, 2021 at 8:28 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > On Thu, Apr 15, 2021 at 6:59 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > Strictly speaking the comparison between guid_t and raw buffer
> > > > is not correct. Import GUID to variable of guid_t type and then
> > > > compare.
> > >
> > > Hmm, what about something like the following instead, because it adds
> > > safety. Any concerns about evaluating x twice in a macro should be
> > > alleviated by the fact that ARRAY_SIZE() will fail the build if (x) is
> > > not an array.
> >
> > ARRAY_SIZE doesn't check type.
> 
> See __must_be_array.
> 
> > I don't like hiding ugly casts like this.
> 
> See PTR_ERR, ERR_PTR, ERR_CAST.

It's special, i.e. error pointer case. We don't handle such here.

> There's nothing broken about the way the code currently stands, so I'd
> rather try to find something to move the implementation forward than
> sideways.

Submit a patch then. I rest my case b/c I consider that ugly castings worse
than additional API call, although it's not ideal.

-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
