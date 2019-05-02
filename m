Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EEA11B1E
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 16:16:26 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2D7E021243BA2;
	Thu,  2 May 2019 07:16:24 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EC1E52194EB7F
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 07:16:21 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w35so604624edd.1
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 07:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=F9aLUsv55ITOjNiKYrvVJTstOAfJJ4bjs1xsqsYJZDQ=;
 b=Wglm0Ja8Is5t6Pe+C39FK43FXDgUihPAL66hPy1y4u5yc2bjsKAODKww+7X5qtMNq5
 PbUXwFDcvRFq0LAgV2XIV24RKvFaLy4+Jk9GJYezxhn5AlNEzzhz8abjwcZNxXD9zlji
 e5nlWFVG4bsIB4/YdkBoDHM6o1TSAyn93KJf3vcwSYLmgFnlgEumav98ILuqSoa4je8o
 AFbnIN4HyiGrHybIdEqKo89zqDoKruqFcQ4OfcjnNLSk5jVrpkfQPrVUs7D0XYOyds57
 zhuWswdfRLeN+sHLVlfRkfc2fNW9damh+qz/C5Exemg6en0dyyKw1qNwtwq2GtQLO5wR
 RaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F9aLUsv55ITOjNiKYrvVJTstOAfJJ4bjs1xsqsYJZDQ=;
 b=sZu7/TdJn7HK+nvNC+KPpMoAXXFEujHlHRMlRuQPTKV/u48bc3V5dc/qjU/uGWMKs2
 OE0XbcjjXptH0pf5nCS06trEOsNMeYO6Ay6M5ZeuQl32K7Mqkmqmh8jPm+wtVjo4I8w0
 tuKA6hCvoA6yGvJFfeyq6f0an3Wo71z3WO6GYX3DzWB3qXEtSnw27j3dh+v/hqdQgrzi
 uxM0YeceTQ38DUi3Hvnz4g9eDg6iW4+zPPme5OnMZ06th6c6JUigCYcI0Kj7x99B4KgJ
 dlvkjxbMwUVHEpYQTxI2WSXGoduNmrED3T6UbmEwZTrnHV/QDAioESvbIJO5fpKlBBSm
 aJTg==
X-Gm-Message-State: APjAAAXTntjWnPxK1Mg2f2dOyGp1BCw3Oxr9u7f6MsZec31SdxCk20/B
 IkNOmZ4H8ahMCTV2ZX9UrsizB+U9pP8yfkcVDMi14g==
X-Google-Smtp-Source: APXvYqz9Dz0MllP0/JVZaWYqSMxagrbWwyxnqyReg5hTSdZBuyzEtjj571LYBRrDHp5eRfJaAMIOIYRbPk8/bxfuLaY=
X-Received: by 2002:a50:a951:: with SMTP id m17mr2606324edc.79.1556806579550; 
 Thu, 02 May 2019 07:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552634075.2015392.3371070426600230054.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190501232517.crbmgcuk7u4gvujr@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
 <CAPcyv4hxy86gWN3ncTQmHi8DT31k8YzsweMfGHgCh=sORMQQcg@mail.gmail.com>
In-Reply-To: <CAPcyv4hxy86gWN3ncTQmHi8DT31k8YzsweMfGHgCh=sORMQQcg@mail.gmail.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 May 2019 10:16:08 -0400
Message-ID: <CA+CK2bA_5uaEK1vjOwNZC9Ta+T-_yTL9etOUEvOUSrtNEOe8og@mail.gmail.com>
Subject: Re: [PATCH v6 01/12] mm/sparsemem: Introduce struct mem_section_usage
To: Dan Williams <dan.j.williams@intel.com>
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
Cc: Michal Hocko <mhocko@suse.com>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 David Hildenbrand <david@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, May 2, 2019 at 2:07 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, May 1, 2019 at 4:25 PM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> >
> > On 19-04-17 11:39:00, Dan Williams wrote:
> > > Towards enabling memory hotplug to track partial population of a
> > > section, introduce 'struct mem_section_usage'.
> > >
> > > A pointer to a 'struct mem_section_usage' instance replaces the existing
> > > pointer to a 'pageblock_flags' bitmap. Effectively it adds one more
> > > 'unsigned long' beyond the 'pageblock_flags' (usemap) allocation to
> > > house a new 'map_active' bitmap.  The new bitmap enables the memory
> > > hot{plug,remove} implementation to act on incremental sub-divisions of a
> > > section.
> > >
> > > The primary motivation for this functionality is to support platforms
> > > that mix "System RAM" and "Persistent Memory" within a single section,
> > > or multiple PMEM ranges with different mapping lifetimes within a single
> > > section. The section restriction for hotplug has caused an ongoing saga
> > > of hacks and bugs for devm_memremap_pages() users.
> > >
> > > Beyond the fixups to teach existing paths how to retrieve the 'usemap'
> > > from a section, and updates to usemap allocation path, there are no
> > > expected behavior changes.
> > >
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > Cc: Logan Gunthorpe <logang@deltatee.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
