Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045DF29CA5
	for <lists+linux-nvdimm@lfdr.de>; Fri, 24 May 2019 19:02:21 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5465C212777BC;
	Fri, 24 May 2019 10:02:19 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EBBF22127779B
 for <linux-nvdimm@lists.01.org>; Fri, 24 May 2019 10:02:17 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id l25so9308451otp.8
 for <linux-nvdimm@lists.01.org>; Fri, 24 May 2019 10:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uxIEMvL9NPIZt76HNNKGot2fHQFb8ScQQVFnfVEGVdE=;
 b=J6E7gPFqhGjQkK6F3GbGp2bqy4JZqM2JGDp4Q4363sxZZKkY1eebXwTOzadjVyNxa/
 AwEmFnD2OnTGLyCOsb4EVByimH7YKeH+ofbH0xOkO83ECfI0kA1wzco1g7dCyhxMmqn1
 lAjQLIEU87kbYcXgUjMEft09EG/s78/uSMvtXR561r30xuSwzTQgeEs/f23iRNxDK0Oq
 iv1DfXdnUJiXSNllUJOnrj1nEQzbEEh613meCgyIzDBkPavcXHBSW8mDbIRUarQv5EPB
 dh51oEmUu1WNnPiJZf+vDq4g8Yp9QXZQJUaZzJ7lJ/aNehbHAk4st7jpd1AxQslcrFO3
 kCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uxIEMvL9NPIZt76HNNKGot2fHQFb8ScQQVFnfVEGVdE=;
 b=TLzVziso9FPrN1Y6Nbi/VG8r/vJHn4KUtgf//a/DaJ8/FTP0nkUJ1RNxWNWpz3khhe
 hIEEtNtfZUpDNSTJ5XEkDKm0lhewBDRYfYHsZVasRRVU/tu/b4GulZmc6UttoLKFu5TR
 jjn+MMS5bZqj7GqyydX3ldrHV2YfnFHuc4BTlSTaMNM40uU39qvm0U+bZxGhSLdEEzDl
 BeB+55psVGCk5tK8yvbLcNr3RdLifNEofd9J87/D+3OS2u3nc7nlPzArm3xee8DC/SqD
 rqk1zVqNKwnCfj66JYhr4iUIugxNbmem7U0vXvQs1iWbK5rL6Akci/KdCVbNKGkDBVY+
 SWxg==
X-Gm-Message-State: APjAAAWQCerUEawLyoEUBoQMyLmJyRBB0QhIEUz/0rPbgPxhUdpIh4A2
 g3vN1kPuu9l7do4AzEBOUSA2i57iuz/6pKaUFXKtLA==
X-Google-Smtp-Source: APXvYqxVRQpBpCep9TCI1kPQh1cOH82JFn3Gk+gMokzzTN7nj9KB6DFm/LKWbO3WZKAfI141c5e4MkYQ3VfCFR+tiNo=
X-Received: by 2002:a9d:2963:: with SMTP id d90mr14793834otb.126.1558717336323; 
 Fri, 24 May 2019 10:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <1557417933-15701-1-git-send-email-larry.bassel@oracle.com>
 <1557417933-15701-3-git-send-email-larry.bassel@oracle.com>
 <20190514130147.2pk2xx32aiomm57b@box> <20190524160711.GF19025@ubuette>
In-Reply-To: <20190524160711.GF19025@ubuette>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 24 May 2019 10:02:04 -0700
Message-ID: <CAPcyv4hkocsPQLQ6sfF8SuwVoot_uXge_bTZtuM-6f4XxwFVhg@mail.gmail.com>
Subject: Re: [PATCH, RFC 2/2] Implement sharing/unsharing of PMDs for FS/DAX
To: Larry Bassel <larry.bassel@oracle.com>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Linux MM <linux-mm@kvack.org>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, May 24, 2019 at 9:07 AM Larry Bassel <larry.bassel@oracle.com> wrote:
> On 14 May 19 16:01, Kirill A. Shutemov wrote:
> > On Thu, May 09, 2019 at 09:05:33AM -0700, Larry Bassel wrote:
[..]
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index f7d962d..4c1814c 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -3845,6 +3845,109 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
> > >     return 0;
> > >  }
> > >
> > > +#ifdef CONFIG_MAY_SHARE_FSDAX_PMD
> > > +static pmd_t *huge_pmd_offset(struct mm_struct *mm,
> > > +                         unsigned long addr, unsigned long sz)
> >
> > Could you explain what this function suppose to do?
> >
> > As far as I can see vma_mmu_pagesize() is always PAGE_SIZE of DAX
> > filesystem. So we have 'sz' == PAGE_SIZE here.
>
> I thought so too, but in my testing I found that vma_mmu_pagesize() returns
> 4KiB, which differs from the DAX filesystem's 2MiB pagesize.

A given filesystem-dax vma is allowed to support both 4K and 2M
mappings, so the vma_mmu_pagesize() is not granular enough to describe
the capabilities of a filesystem-dax vma. In the device-dax case,
where there are mapping guarantees, the implementation does arrange
for vma_mmu_pagesize() to reflect the right page size.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
