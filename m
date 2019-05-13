Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAE91BF04
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 May 2019 23:12:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9EBEA212741EA;
	Mon, 13 May 2019 14:12:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 53C0F212741E6
 for <linux-nvdimm@lists.01.org>; Mon, 13 May 2019 14:12:07 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id t24so4475058otl.12
 for <linux-nvdimm@lists.01.org>; Mon, 13 May 2019 14:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ehW85Lrv2Q48sCjGFVYU8EiJvcqJ/cEoN0rsLhKwFn4=;
 b=DDH2tF8rRfIjsd+6p3tNZ6N0FrylBCHLkuudu7uIV1T1yuGKEfmS5nhaufD2LxCH0n
 G845ptMmk8uLtcFNrOm9RJ/y5yUNcE06KAhjuzSEvjcwqluLZzThkkFoVLMzDS/GRFiQ
 E3YJqmPgTJDanm2yChPEe9Htk6yEnKKy74gZ1xdIUD/wHzbHnBDGzYiaAisiKcyMiL43
 a7ia7WeecOqq9//fSUFEgti9KcdEQBl+Yf08zwAb8MthphEbW8tsStK9BfeWjBslJy9P
 /aU3hHSwS4cAoxn925mw+G8S7Zm+GNjhEPotnhkBeJGxfQcKkGFVGwhIkvS82qmcTcOv
 6R5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ehW85Lrv2Q48sCjGFVYU8EiJvcqJ/cEoN0rsLhKwFn4=;
 b=SMzSeIf1awZFWR/lluwAEsInJ1kSsT5X5ZellEfWLFQ8Eot7P+27y7w7jWRa8O0mj8
 2xtZDjEMwztqaubRkDUB7vLzHVOeCM36kbYBWZ4PdQuc4mUhiU44lxK7oLW4lH+ykt/O
 vaDfV4NyMgX8woRtKqMk3krZtVW/akuupTfIPVMRC6MvXO1I8fmYF++tEL2y2gUfgGtC
 3fqF3T64oW+ze3KFM4LZv9rZKn2YlznNX7WfQMQc1SViGvJrkGotwPR6kJVfcT8UFO9o
 xfS01yMppg9291uiDm1rupTOtrI3w2Zeyb0OJDox5ju/VHtAUUCoWLxTaFrrxTxbsS32
 +GfQ==
X-Gm-Message-State: APjAAAU1/547ftAd0c2xuVWgMt+4wKAL4kylrhO1nlQf2rbW2Jk2auFw
 BqD9kfEL3CZRfsKRbLJyllZ99WVWNnKD40Rb/QRi1w==
X-Google-Smtp-Source: APXvYqwIGJ0PBLErnWxuRYnfK8Gzj1P5cw9UmR9BtnvGHQjAVMKGB06nxi/SpfU6EmNEkLZmuWLghYQYRcySk2jRhMk=
X-Received: by 2002:a9d:6f19:: with SMTP id n25mr12997789otq.367.1557781926319; 
 Mon, 13 May 2019 14:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <155718596657.130019.17139634728875079809.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190513210148.GA21574@rapoport-lnx>
In-Reply-To: <20190513210148.GA21574@rapoport-lnx>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 13 May 2019 14:11:54 -0700
Message-ID: <CAPcyv4he64-d=govm4+OEt75gxeuLZcrwrhow5dT=rA3KwQ4JA@mail.gmail.com>
Subject: Re: [PATCH v8 00/12] mm: Sub-section memory hotplug support
To: Mike Rapoport <rppt@linux.ibm.com>
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
Cc: Michal Hocko <mhocko@suse.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 David Hildenbrand <david@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Anshuman Khandual <anshuman.khandual@arm.com>, stable <stable@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, May 13, 2019 at 2:02 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Hi Dan,
>
> On Mon, May 06, 2019 at 04:39:26PM -0700, Dan Williams wrote:
> > Changes since v7 [1]:
>
> Sorry for jumping late

No worries, it needs to be rebased on David's "mm/memory_hotplug:
Factor out memory block device handling" series which puts it firmly
in v5.3 territory.

> but presuming there will be v9, it'd be great if it
> would also include include updates to
> Documentation/admin-guide/mm/memory-hotplug.rst and

If I've done my job right this series should be irrelevant to
Documentation/admin-guide/mm/memory-hotplug.rst. The subsection
capability is strictly limited to arch_add_memory() users that never
online the memory, i.e. only ZONE_DEVICE / devm_memremap_pages()
users. So this isn't "memory-hotplug" as much as it is "support for
subsection vmemmap management".

> Documentation/vm/memory-model.rst

This looks more fitting and should probably include a paragraph on the
general ZONE_DEVICE / devm_memremap_pages() use case.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
