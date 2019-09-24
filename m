Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3109BD059
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Sep 2019 19:12:32 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8EF9F202F73AF;
	Tue, 24 Sep 2019 10:14:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2913221A00AE6
 for <linux-nvdimm@lists.01.org>; Tue, 24 Sep 2019 10:14:50 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 67so2178610oto.3
 for <linux-nvdimm@lists.01.org>; Tue, 24 Sep 2019 10:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dcgzuDsQCpFn121b/ql7O8ocBFnw5Hkk+VWwRabf1hw=;
 b=hF7n6OXqOhBt4eWibKgJtXUPDOIexeWq90z68FeSAycsIdx/1Wf+Y+T9wvzkqkoWHj
 SKavoQuYeB8LtKJnWjHp6Q0TDbLNaT9uBLR8GdOqzqg0a96/on0kUDihtmeeM6j+6O1T
 IvAg8tfeM9McLYWE0/He2TSPpgDbdV1kSzhwolzwGxN5Fq5Fb0n7TDviiWJYhMtlRyrU
 qu2/u41bMwbfO6PCESVXvLtMxbutFaA76de8CRQ45DRpUIwcSDX954hJPGerV7hSVybl
 FZauETJnFZ79zMQhLWCCP0NpB96LSs29J375RWOcKh/Zuf2CcVb3kFTeWs2Q/5JH+jMO
 kVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dcgzuDsQCpFn121b/ql7O8ocBFnw5Hkk+VWwRabf1hw=;
 b=d4QKCgsZBgE195UAr2BoNdynK8LaNTTABjKW+vMDXsvMgcEJnxgSYtv+ZFfSNVzBB8
 JB8oANJmyUM5TCA/2vi2k43YoLS6QtlG3UUEg3PhS2LsXTt+2lSVVahxnTgu9v56XFkl
 sJNm19ljY6eDATdkQdssHDOIJ+DiyFwREwd0eYZiGaSkFhP/EgrFvgCARaSs82hpXC35
 Veo/ft57iam2WsWM/t+TyiWF8Y05Ocv/5++8yHV4y7RzUKsv/JC9owgkAN3rLlBiTjfN
 V1Zy48/jj6dJJIq7H1I5WsIdHexuTTmVhy48kEKOkEV93xnYKsX6KG4L4GeAzSO/Zo/t
 XMwA==
X-Gm-Message-State: APjAAAWKVlJt7xQcIxYZzA6FjV9Z42oCDkm+2trx0UkMs8A9UP232PK0
 blG4PWJOqBM+PJ9CKUm0jTjd29SJ6Af+sibDVhckKQ==
X-Google-Smtp-Source: APXvYqwm0iW71gyMg2PC59h8nEdCx2ELFFZUnDYfLQ8+YKhMQkzDwaZgV+Ba1UljaBfzsvjv3/335qC5EkGHt/TC0Dw=
X-Received: by 2002:a9d:2642:: with SMTP id a60mr2622413otb.247.1569345148061; 
 Tue, 24 Sep 2019 10:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190924114327.14700-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4iQbM5R0dukZX8wCQx4dD8NAevQWnHWe4hC7kHBcDcNow@mail.gmail.com>
In-Reply-To: <CAPcyv4iQbM5R0dukZX8wCQx4dD8NAevQWnHWe4hC7kHBcDcNow@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 24 Sep 2019 10:12:17 -0700
Message-ID: <CAPcyv4ij2+i9O15ZTx3VSLEF7wQM5ukfncVY42g4S1VWX8zTrA@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/region: Update is_nvdimm_sync check to handle
 volatile regions
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

On Tue, Sep 24, 2019 at 9:57 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Sep 24, 2019 at 4:43 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
> >
> > We should consider volatile regions synchronous so that we are resilient to
> > OS crashes. This is needed when we have hypervisor like KVM exporting a ramdisk
> > as pmem dimms.
>
> We have a hard time understanding what agent is being referenced when
> we use "we" in a patch changelog. We would prefer that we consider not
> using "we" in favor of explicitly named agents, or otherwise review
> the changelog to make sure that "we" is clearly discernable. We will
> fix it up this time when applying, but we hope we have made it clear
> how confusing liberal use of "we" can be.

To be clear, I'm not strictly opposed to using "we" when it is
established which we is being referred and stays constant throughout
the description. This instance caught my eye again because the first
couple "we"s seems to be the kernel, and the last we seems to be a
user platform configuration.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
