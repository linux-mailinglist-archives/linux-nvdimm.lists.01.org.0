Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C52AE651
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Sep 2019 11:09:12 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 35255202BB9B5;
	Tue, 10 Sep 2019 02:09:29 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 66E7220294F07
 for <linux-nvdimm@lists.01.org>; Tue, 10 Sep 2019 02:09:26 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id y39so17383931ota.7
 for <linux-nvdimm@lists.01.org>; Tue, 10 Sep 2019 02:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gzySq2KgU23Lz62leK1/JYGc7N1eDn8ko0/2bOX2/jA=;
 b=QYcl9tvm/E8Bmj+3/7A3sDwjTV1JrxFts8PHtnSfl9Bfcoq69qypc9U89qKqe0f2EQ
 uuEh2GnVcws7kS/Fagzex3PDMNhSLBJJCrY3T2z0ANeyE9jsY53teLqUKwYt/vtafWQS
 ysom1jPbg2ko8BjpXumMqfTLNJTH0iIqMIwLTQwxodyLaz6ozOgvmz7k5fQWUl4L1Uwa
 E27aXddAqDmNOG76TH4rj5U6zOgHz1WW1SaIE8IBJmKVYCoxKXGd42J82Q8Mf9ArWfjr
 CwkuOzAYgnlLdBClYwWOtChPPBl0xkoXSCdbGM6HGLduIhfJo7j1t4egYJ+EuC0QN7yn
 n19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gzySq2KgU23Lz62leK1/JYGc7N1eDn8ko0/2bOX2/jA=;
 b=J6D7a3721aCNi349tWu3PeKiL3CntCpc/PFVaUinKKWwOujVBekthOq4Y3iG1eYtan
 M06kKxFOBeQ1gmAMwnSsPZqpfPGFFyPdwNcGialW4C5p8qe+YI8sNxdmnmirqEgSCMtt
 9BiX/vJMhrLtgiI9kGfS/edoYknEwW2ocaH0WOaFYVA1REMktHC2OxmJTBdpJfT2Sg87
 8bGoz7a9/MgxdqKuKvRFgnDZK1hFn+v9QS9ufbqucdcSoiwC7Y1OCnbZ0W1U3T/PuWbG
 Q4wwv9/DEFemEOc7s0YOx0mw5N/MeESExG44CNuOIcgiG7Y6G4fAaNtDqHmpMsAW3NFK
 QP/A==
X-Gm-Message-State: APjAAAVG57MtdzbFcPUJCo9nHZZwugofZo+MSboTfgv5dxzZ1/MzBVI2
 nrXKqLC9RJ0hb0u/QYIgn5KCVgSe3bzhqoeMPGcHxg==
X-Google-Smtp-Source: APXvYqxwLshjInXu0oU2m4xsjP474lcUaazRBBAqlBtfF7xR3iJNA8yJ0eNDpzK0DGmThD+e5HZt29ol1d8Q4WS4GVY=
X-Received: by 2002:a9d:6d15:: with SMTP id o21mr25318322otp.363.1568106545407; 
 Tue, 10 Sep 2019 02:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190910062826.10041-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4jmO381oLTHBM80jNy6uNNkXvsOyGTjqSY4zzaS6-4_nQ@mail.gmail.com>
 <14129b58-37a5-56f5-9e90-8740400d07f6@linux.ibm.com>
In-Reply-To: <14129b58-37a5-56f5-9e90-8740400d07f6@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 10 Sep 2019 02:08:53 -0700
Message-ID: <CAPcyv4iYjz-v23eHkhnJqE4wnvoE2uvJ5HE9xrwPCnOCVZ3G2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] libnvdimm/altmap: Track namespace boundaries in altmap
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Sep 10, 2019 at 1:31 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 9/10/19 1:40 PM, Dan Williams wrote:
> > On Mon, Sep 9, 2019 at 11:29 PM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> With PFN_MODE_PMEM namespace, the memmap area is allocated from the device
> >> area. Some architectures map the memmap area with large page size. On
> >> architectures like ppc64, 16MB page for memap mapping can map 262144 pfns.
> >> This maps a namespace size of 16G.
> >>
> >> When populating memmap region with 16MB page from the device area,
> >> make sure the allocated space is not used to map resources outside this
> >> namespace. Such usage of device area will prevent a namespace destroy.
> >>
> >> Add resource end pnf in altmap and use that to check if the memmap area
> >> allocation can map pfn outside the namespace. On ppc64 in such case we fallback
> >> to allocation from memory.
> >
> > Shouldn't this instead be comprehended by nd_pfn_init() to increase
> > the reservation size so that it fits in the alignment? It may not
> > always be possible to fall back to allocation from memory for
> > extremely large pmem devices. I.e. at 64GB of memmap per 1TB of pmem
> > there may not be enough DRAM to store the memmap.
> >
>
> We do switch between DRAM and device for memmap allocation. ppc64
> vmemmap_populate  does
>
> if (altmap && !altmap_cross_boundary(altmap, start, page_size)) {
>         p = altmap_alloc_block_buf(page_size, altmap);
>         if (!p)
>                 pr_debug("altmap block allocation failed, falling back to system memory");
>         }
>         if (!p)
>                 p = vmemmap_alloc_block_buf(page_size, node);
>
>
> With that we should be using DRAM for the first and the last mapping,
> rest of the memmap should be backed by device.

Ah, ok, makes sense.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
