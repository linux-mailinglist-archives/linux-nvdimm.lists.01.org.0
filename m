Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C30BE279663
	for <lists+linux-nvdimm@lfdr.de>; Sat, 26 Sep 2020 05:31:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C0C2214DF6634;
	Fri, 25 Sep 2020 20:31:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 747B214DF662F
	for <linux-nvdimm@lists.01.org>; Fri, 25 Sep 2020 20:31:38 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id nw23so1263964ejb.4
        for <linux-nvdimm@lists.01.org>; Fri, 25 Sep 2020 20:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UI5cEN8K/GeU1uj0Hlr3P0QJH4xnq6J/e8uw5E+CELg=;
        b=nFM9EXLswqbb5477o4UUgt06gbHZd30tqKoruqN9TU7ki2iygmPrxb7yud48jxEgZq
         AMdDChWJGTw00YcdVmLrbNsz96hgAYy9rLT8Q0eewH1VILl3IBRfLrHEAuRIrjY4TwNO
         a/fZ4xfdXd7wgLUEhzggKOZEVmSqrVywkt7nRGs7sNL6j0nuJQhoK00IBAhEs2IYCNU7
         RAPowAucxxNYdJYteLM9uVq9Y5T/f7buOcPqzEhhqz7OSigsqGF95NI1/MOQ6bjw21RE
         eIrb7wntjMtTIXAMQoss9yw159RS/dEAB3wDiNdJgcqObuKazZObmWqT2gO5VJIlKVmY
         wEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UI5cEN8K/GeU1uj0Hlr3P0QJH4xnq6J/e8uw5E+CELg=;
        b=udB/AO+t6ORA72L0EGy1bFpboWlAiKrVyIjovWL0yLVkWjad8iSvNkG115LVZ2BHDN
         87lKPczshAardeCsx+5sM25UianIUyf3oMB/D4JXK6o0dI1mK+ndRu+MzW+wLeKOQcCV
         K5NzOdkYLYizzWOtBcJ3S69RmbWC8mGSt+R07NNwgeR01TaUQaMkQumPdka2DgUeOJ8+
         FE+pStNhHvAjMVdB4ej4Nifyfe0gjXEqD+shA3ku8JM9PFs1Ud5A7DrpFMujLMFJcla1
         yabbAYGHDBY0uzAWLrtZXxYr/spPQOK8bMoVorzspZFLfMA8Nzp4oXsO6ZjSoPvmGzVo
         m47g==
X-Gm-Message-State: AOAM533eThBXpVp8PY6lAoEDJgTKsakG4vt0Im4r5m7Cmr+j/quMmiMU
	3j5ETAN3i3ozSgLydZZ7R8xUSEay3u3jyxL6cwy7Mg==
X-Google-Smtp-Source: ABdhPJzT9T905L59sMxHvdd3yvvw2e/dtiHXcaPuK+9fYnGGItRqKC2gQWw5Zi1v0zAPXBfy/TsQ6vOApAyCmQ7bvxA=
X-Received: by 2002:a17:906:d7ab:: with SMTP id pk11mr5686686ejb.472.1601091096174;
 Fri, 25 Sep 2020 20:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
 <160106118486.30709.13012322227204800596.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200925192234.33ae92b75012c1f2bdd974b8@linux-foundation.org>
In-Reply-To: <20200925192234.33ae92b75012c1f2bdd974b8@linux-foundation.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 25 Sep 2020 20:31:24 -0700
Message-ID: <CAPcyv4gO0jiNGrZkn8VBh5ZJAUOFTn4LAs4CE9tB++0ryX_J=w@mail.gmail.com>
Subject: Re: [PATCH v5 15/17] device-dax: add an 'align' attribute
To: Andrew Morton <akpm@linux-foundation.org>
Message-ID-Hash: BAU4SVOQNJTL4BQDZRVPYY2WXIWIDNHH
X-Message-ID-Hash: BAU4SVOQNJTL4BQDZRVPYY2WXIWIDNHH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>, Dave Hansen <dave.hansen@linux.intel.com>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BAU4SVOQNJTL4BQDZRVPYY2WXIWIDNHH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 25, 2020 at 7:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 25 Sep 2020 12:13:04 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Introduce a device align attribute.  While doing so, rename the region
> > align attribute to be more explicitly named as so, but keep it named as
> > @align to retain the API for tools like daxctl.
> >
> > Changes on align may not always be valid, when say certain mappings were
> > created with 2M and then we switch to 1G.  So, we validate all ranges
> > against the new value being attempted, post resizing.
> >
> > Link: https://lkml.kernel.org/r/159643105944.4062302.3131761052969132784.stgit@dwillia2-desk3.amr.corp.intel.com
> > Link: https://lore.kernel.org/r/20200716172913.19658-3-joao.m.martins@oracle.com
> > Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >
>
> The signoff chain implies that this was From:Joao.  Please clarify?

Yes, sorry, my script to squash the fix rewrote the author and I
failed to catch it. This indeed should be:

From: Joao Martins <joao.m.martins@oracle.com>

I double-checked, and it looks like this was the only one in the
series with that problem.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
