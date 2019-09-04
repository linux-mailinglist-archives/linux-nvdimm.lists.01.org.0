Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C197A8733
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Sep 2019 20:12:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 13E7F20260CE0;
	Wed,  4 Sep 2019 11:13:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7444C2021DD5E
 for <linux-nvdimm@lists.01.org>; Wed,  4 Sep 2019 11:13:51 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 21so14108125otj.11
 for <linux-nvdimm@lists.01.org>; Wed, 04 Sep 2019 11:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m0cJghqoW/n+LvYnSQ3z9W/ef3rzSUyrLznCM/TnehY=;
 b=ddZcnGMFDGowoXKy1JWHWoBloGHqj718fnf0h+VdhjKfRuF/C/hEtz8529X3OF+WI5
 PIsrquhQznZint51FgU7OkVEr2Txve/2uuHMx/Dh8bePHBNOi8cLDda9DczHOOm/4F+v
 /+u1D9EE+NX8v/Ts5E1Rrmio8M7dQSiHj8hnR+mElhB/IMi3eqQ1ym5Mf4reKQQLRlhV
 f/uStiBxiB/wKrB8PnRzvptQP8V0ErylezlDNiYcWYe1Ct1oSmLTuiUy3QBfpgfrXp5Y
 paD0uvDBmu7d7bDgLn91Iyp2YUJxn2NEJAhjFq+yRUD2geHIIdW7ZUSdRe2ncqmTAsaf
 dPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m0cJghqoW/n+LvYnSQ3z9W/ef3rzSUyrLznCM/TnehY=;
 b=OYVP39xtdTEbagIdMB7g6n5RSkZLnhEd2vRjx4vgFyJBRD+xxliyV1lselk4SObpRa
 Yf8x5EOD4GAJ4ditT/JB201eoRUpYbrWf5AbnSSik8EE0t57LBZKWg7ZfYE55CR7ULN/
 BKcfmAs6Q1N9EdhYzlCzwT8lgyXW26bhC7LB95Z1jPUfmfOUN7jJMe8NTPtOWuj3IQCG
 zQi8qWka16kybulhaz5Hk67hiJCoO4T+faggaGnOJOIp/qteRmB8pRFD3XQqxrnWO2WT
 XeVn7CGVG5O9smWa22lKkGZjfW0gtEhurmczO9CUi4W+it+rIr0OclH/gRrSec5MNzfV
 LX+A==
X-Gm-Message-State: APjAAAXkaPOfSiENP6l9Nv/IbNnGHu5qkJ0x57jNaGlE+wgi4LxlW1I7
 Cg+Lf/qu1uWs5mAYfKLxoUJeuH3lPyu4E8Oc4hCOKtqV
X-Google-Smtp-Source: APXvYqzpP2d/PGp9U4vD+CcAheBa5HMP4tCZTBQ7bmO1Gx2sx9NHlr9/GkyRVoBz/j0W8Vy8APDkd+afIA1xhwD+iPo=
X-Received: by 2002:a9d:6d15:: with SMTP id o21mr8753240otp.363.1567620766373; 
 Wed, 04 Sep 2019 11:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190904050822.23139-1-aneesh.kumar@linux.ibm.com>
 <20190904050822.23139-8-aneesh.kumar@linux.ibm.com>
 <77c345a4-a317-2f42-f21c-4c2c98983565@linux.ibm.com>
In-Reply-To: <77c345a4-a317-2f42-f21c-4c2c98983565@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 4 Sep 2019 11:12:35 -0700
Message-ID: <CAPcyv4iTOuXiMLok3MbhgF9xnWCrdoDJMMukg7kgmPZHD62XyQ@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] libnvdimm/dax: Pick the right alignment default
 when creating dax devices
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Sep 4, 2019 at 12:07 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 9/4/19 10:38 AM, Aneesh Kumar K.V wrote:
> > Allow arch to provide the supported alignments and use hugepage alignment only
> > if we support hugepage. Right now we depend on compile time configs whereas this
> > patch switch this to runtime discovery.
> >
> > Architectures like ppc64 can have THP enabled in code, but then can have
> > hugepage size disabled by the hypervisor. This allows us to create dax devices
> > with PAGE_SIZE alignment in this case.
> >
> > Existing dax namespace with alignment larger than PAGE_SIZE will fail to
> > initialize in this specific case. We still allow fsdax namespace initialization.
> >
> > With respect to identifying whether to enable hugepage fault for a dax device,
> > if THP is enabled during compile, we default to taking hugepage fault and in dax
> > fault handler if we find the fault size > alignment we retry with PAGE_SIZE
> > fault size.
> >
> > This also addresses the below failure scenario on ppc64
> >
> > ndctl create-namespace --mode=devdax  | grep align
> >   "align":16777216,
> >   "align":16777216
> >
> > cat /sys/devices/ndbus0/region0/dax0.0/supported_alignments
> >   65536 16777216
> >
> > daxio.static-debug  -z -o /dev/dax0.0
> >    Bus error (core dumped)
> >
> >    $ dmesg | tail
> >     lpar: Failed hash pte insert with error -4
> >     hash-mmu: mm: Hashing failure ! EA=0x7fff17000000 access=0x8000000000000006 current=daxio
> >     hash-mmu:     trap=0x300 vsid=0x22cb7a3 ssize=1 base psize=2 psize 10 pte=0xc000000501002b86
> >     daxio[3860]: bus error (7) at 7fff17000000 nip 7fff973c007c lr 7fff973bff34 code 2 in libpmem.so.1.0.0[7fff973b0000+20000]
> >     daxio[3860]: code: 792945e4 7d494b78 e95f0098 7d494b78 f93f00a0 4800012c e93f0088 f93f0120
> >     daxio[3860]: code: e93f00a0 f93f0128 e93f0120 e95f0128 <f9490000> e93f0088 39290008 f93f0110
> >
> > The failure was due to guest kernel using wrong page size.
> >
> > The namespaces created with 16M alignment will appear as below on a config with
> > 16M page size disabled.
> >
> > $ ndctl list -Ni
> > [
> >    {
> >      "dev":"namespace0.1",
> >      "mode":"fsdax",
> >      "map":"dev",
> >      "size":5351931904,
> >      "uuid":"fc6e9667-461a-4718-82b4-69b24570bddb",
> >      "align":16777216,
> >      "blockdev":"pmem0.1",
> >      "supported_alignments":[
> >        65536
> >      ]
> >    },
> >    {
> >      "dev":"namespace0.0",
> >      "mode":"fsdax",    <==== devdax 16M alignment marked disabled.
> >      "map":"mem",
> >      "size":5368709120,
> >      "uuid":"a4bdf81a-f2ee-4bc6-91db-7b87eddd0484",
> >      "state":"disabled"
> >    }
> > ]
> >
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>
> v8 for this posted at
>
> https://patchwork.kernel.org/patch/11129463/

I understand the urge to not re-send the full series, but it ends up
confusing the tooling and requiring me to do manual work to assemble
the patch set.

I use "git-pw" to pull down patch series and the tool did not
understand the two versions of patch 7. So for linux-nvdimm at least,
please resend the full series.

I do have a comment on v8 so a final v9 might be needed.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
