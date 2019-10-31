Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5BFEB447
	for <lists+linux-nvdimm@lfdr.de>; Thu, 31 Oct 2019 16:53:32 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 87F0F100DC409;
	Thu, 31 Oct 2019 08:53:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6668D100DC407
	for <linux-nvdimm@lists.01.org>; Thu, 31 Oct 2019 08:53:56 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id d8so5797452otc.7
        for <linux-nvdimm@lists.01.org>; Thu, 31 Oct 2019 08:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2RX5Wx5xiTLYEovRDDFwLuk9JtNaRdVkZVutueAa7Zk=;
        b=bvfA7G23dHAFFSvf+zNar2jGgrlvY+QxT0t3ad89+EPZ0zHZehpyTafYW5/3TQP2qz
         ylAbGI8DkwLWrXRPYe5pHVzrfSHNTd3D1WPId48yb9jlWZ4lXVEbkY5Ke0u0yH0HNK0i
         Xm1+WtSzbGt0V0qiFcfMsU+6xOXyRqOusRamz+glDw5ugBfGMm+cfDmBlYV5LqeKUpMv
         SZalR7VCHbbyvHGSVXmfNHt2VEXhUxSAFLQzklbbRXiSZ7iRmY142ZBn46J1SelSqugJ
         aaQf3nenbXjvZ8STcimhNbaIhJhSxkOMvKCU52YLwcxdRqPgFnJMfPmIoxtU7owqZBOT
         9pGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2RX5Wx5xiTLYEovRDDFwLuk9JtNaRdVkZVutueAa7Zk=;
        b=txtq4npNp+YIoxOTCidX/grUmde+Mr7tSGWFFRjsxRPur3vSDvRrZOHdXvIEzrmytc
         sweiOT3CQbQTzVpEOFZcybxCcX3271zw+zswJVkZvKbNOVAPnTBBphXynsTYpoIZI4TJ
         RUxinssC9lduWQvG1j/ZjKdX10l5ThDhLT2tl2CyI7IXeVOMlEll8+Y96KXewX5luH4d
         0UwvLRjf8qqG06VFK+jemsNlrd5GFvhHsClNNRkjt0CBLnTpk/cCgdPIsH7OVbdlasC6
         s9hNeg0U1Bm7VTURLyibX7jRz+iGomT8mdeV8333uTXmacWoLgIKPjkiLrK0Xd/BS9Wp
         Kajg==
X-Gm-Message-State: APjAAAWX8Tto/7OWLpKHILCUZY5RKTnfoAv52WgqkuVwKg2r96oH420N
	t8TMn5seq2ML1SOZoIaUZAMl/ESPIzxEBig+L6GLJA==
X-Google-Smtp-Source: APXvYqzGdjUw+psWya1RpMgMepPJxL73tV8uam0VjV5PduuJ7qULjorWMWe4/qApk2lgE5RCcNSLcX6AFBPSOOiTFI8=
X-Received: by 2002:a9d:5f11:: with SMTP id f17mr4971128oti.207.1572537208078;
 Thu, 31 Oct 2019 08:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191028094825.21448-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4gZ=wKzwscu_nch8VUtNTHusKzjmMhYZWo+Se=BPO9q8g@mail.gmail.com>
 <6f85f4af-788d-aaef-db64-ab8d3faf6b1b@linux.ibm.com> <CAPcyv4gMnSe26QfSBABx0zj3XuFqy=K1XaGnmE3h3sP3Y76nRw@mail.gmail.com>
 <4c6e5743-663e-853b-2203-15c809965965@linux.ibm.com> <CAPcyv4h42_1deZDaaW1RqX0Ls+maiFO_1e=6xJuHTa3wdWvVvA@mail.gmail.com>
 <8e29b94c-cb82-2632-965c-567d26791f76@linux.ibm.com>
In-Reply-To: <8e29b94c-cb82-2632-965c-567d26791f76@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 31 Oct 2019 08:53:17 -0700
Message-ID: <CAPcyv4hS8sCNvDh2H0_LCR1uOYf8XeDYq6CWkAjPMoDyrp4+FA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] libnvdimm/namespace: Make namespace size
 validation arch dependent
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: ZDP7K5FSISKIBFO3CSKPA5BDJMUI432X
X-Message-ID-Hash: ZDP7K5FSISKIBFO3CSKPA5BDJMUI432X
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZDP7K5FSISKIBFO3CSKPA5BDJMUI432X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 31, 2019 at 1:38 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 10/31/19 12:00 PM, Dan Williams wrote:
> > On Wed, Oct 30, 2019 at 10:35 PM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> > [..]
>
> >
> >
> > All that said, the x86 vmemmap_populate() falls back to use small
> > pages in some case to get around this constraint. Can't powerpc do the
> > same? It would seem to be less work than the above proposal.
> >
>
> ppc64 supports two translation mode (radix and hash). We can do the
> above with radix translation. With hash we use just one page size( in
> this specific case 16MB) for direct-map mapping.

Ok, if it's truly a hard constraint then yes, more infrastructure is
needed to expose that constraint to the namespace provisioning flow.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
