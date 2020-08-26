Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A69E253845
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Aug 2020 21:26:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1E8FE1237CDD1;
	Wed, 26 Aug 2020 12:26:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::642; helo=mail-ej1-x642.google.com; envelope-from=miklos@szeredi.hu; receiver=<UNKNOWN> 
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 762D612379B1F
	for <linux-nvdimm@lists.01.org>; Wed, 26 Aug 2020 12:26:42 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id d11so4389097ejt.13
        for <linux-nvdimm@lists.01.org>; Wed, 26 Aug 2020 12:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYKPTufiMBAMoTNCgDN7PLKKjOS7TYvnr9DjmBNmXfM=;
        b=FaUxUnjKb0N9Xw2K3ckURq7XBP2BC7VSd74QmXqnGlHpmfsTcG0/cbq0wjQ72NwmtM
         /XRHgHj1rfJMGI+1Wj3VNHM4uo0IrKuS9FTep4/wvrAttKznUFlA2UZIfJWJPZoJ06Ei
         s2yVxWhOI+28JDFT+R83RAGBwXVvIqe78CshI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYKPTufiMBAMoTNCgDN7PLKKjOS7TYvnr9DjmBNmXfM=;
        b=moB8Ma0lzMTxR3LQCLQKF+uDUxQLbMCwFheFUSwFaZ7G595I4/6w5V0VlZeYUtngM+
         H/VdgOT0hI4S5tywCqTpp+QTLWsJF7fU+1SHzpuSermoChCMiddB4gauqg0pTnQQ510d
         sSks6L8Kd6pqR1vdIWbL+5ftyHu8T6w3/Jr5XsBKTrpH2oERbISb/fepS9ccTTrjis1R
         APTnXb5dhqQD2vqHqWRUlSWBiXiVlAM3FpoLPwwerAvcA4FXP2NA6ZYkaJNt5yFQAzbP
         Z7FhSdTAua2b3u6Z5Tv2XgUG1rUvLtZBrcyvLWXSo6PwL18Lzz0Ewjhjt5kn2no+iL+E
         9H1A==
X-Gm-Message-State: AOAM530r51Fs9ZYaWUmz93t9rfhpIAlq4O4q9iWzfLZOGSwM/ceu3egQ
	A3V94S8KLk8bw6F1c16ZwxTca7WaBQAV/XSk57EKSA==
X-Google-Smtp-Source: ABdhPJySXvtS1wt72dlTMaNXkc4ygI3g/9G+dTkz6T/HxF6o7ikX7c/MufNQgXY1U/W7PJiGBF7gwXubMG5akFPdVoI=
X-Received: by 2002:a17:906:b2d7:: with SMTP id cf23mr17037501ejb.113.1598470000611;
 Wed, 26 Aug 2020 12:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200819221956.845195-1-vgoyal@redhat.com> <20200819221956.845195-12-vgoyal@redhat.com>
 <CAJfpegsgHE0MkZLFgE4yrZXO5ThDxCj85-PjizrXPRC2CceT1g@mail.gmail.com>
 <20200826155142.GA1043442@redhat.com> <20200826173408.GA11480@stefanha-x1.localdomain>
 <20200826191711.GF3932@work-vm>
In-Reply-To: <20200826191711.GF3932@work-vm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 26 Aug 2020 21:26:29 +0200
Message-ID: <CAJfpegvqZUXsvbWg8K-xosNR+RVwRm2KH+S9mKs6n6Sv65s+Qg@mail.gmail.com>
Subject: Re: [PATCH v3 11/18] fuse: implement FUSE_INIT map_alignment field
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID-Hash: WE4B6Q4KDUR4QIWMXPZ7OR34PH42YKDQ
X-Message-ID-Hash: WE4B6Q4KDUR4QIWMXPZ7OR34PH42YKDQ
X-MailFrom: miklos@szeredi.hu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs-list <virtio-fs@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WE4B6Q4KDUR4QIWMXPZ7OR34PH42YKDQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 26, 2020 at 9:17 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:

> Agreed, because there's not much that the server can do about it if the
> client would like a smaller granularity - the servers granularity might
> be dictated by it's mmap/pagesize/filesystem.  If the client wants a
> larger granularity that's it's choice when it sends the setupmapping
> calls.

What bothers me is that the server now comes with the built in 2MiB
granularity (obviously much larger than actually needed).

What if at some point we'd want to reduce that somewhat in the client?
  Yeah, we can't.   Maybe this is not a kernel problem after all, the
proper thing would be to fix the server to actually send something
meaningful.

Thanks,
Miklos
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
