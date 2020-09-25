Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC222792D9
	for <lists+linux-nvdimm@lfdr.de>; Fri, 25 Sep 2020 23:01:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 953F6154EA1A1;
	Fri, 25 Sep 2020 14:01:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::644; helo=mail-ej1-x644.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1F123154E35B8
	for <linux-nvdimm@lists.01.org>; Fri, 25 Sep 2020 14:01:49 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id lo4so481200ejb.8
        for <linux-nvdimm@lists.01.org>; Fri, 25 Sep 2020 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k1HBr67Ra9XD8Qto5IYLfIorshpKmidVCi7EV9X3ssA=;
        b=VVRXzrYwvG3Z0Gn4lOVTifjiE4oRRKeIhUzTVLkI1NNLFEbWjqmM5ejCHh2j1zsT1k
         lIG4wxOiyNkRDEK9QSA+pqeW/q64To+33QaVyXoRmeecwHK1cOzbebXMNJid+WHzAap3
         wJkw/4fRQoItzRRgQjRrM0/QdLy+8K6zRBg1BOdfVmRjU5p8wa/+apJOY0B12VmmRvN4
         sUu5sK48nEz23VAXLUmVAV/mBna3N/1vOYo59dyfP+klGaNvHtJkqNXzY9Zh7nIWDQrA
         V3Jlkj+OtqhCfj7rtAKzmtZDswAnmPcR00SSA34lr4sLZIOrCLeGZK8cZxInK53Ax/NX
         gQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k1HBr67Ra9XD8Qto5IYLfIorshpKmidVCi7EV9X3ssA=;
        b=RSaRr5FK3iqFCksSaBu/FaNSFBeXzmq6ofW+Ax0vEgZ37gvxTcEqJK6XXiLMW1F7bX
         TLEVEyXE8U8NfBXpO/YfIT9saANiR559dEDhg86CVEiCipNAcBlZRJ8e1nK9aMggXU4S
         LsRg2XRe4y6LgKjw/+8iBJqLnFyFNZ0hi0+4pZFyGlloBsh6ykDu2m4G5K1JmAriDOEZ
         rzhFN0FX0yIDatL+6jlRvCxOnu7Go2Q7FO4MaihRZLXj/OmeCsqtt2AWyYQEUnWPobtm
         b5rfjAnYn06+vq9Xe5h0epRR7w/086s9LZjyWQ5KXPfUGtq9CJq/GRA9wdVvhw+JkAAh
         JFTw==
X-Gm-Message-State: AOAM531YWJS0mMTtJXACsxlHRtAzBAhkgfA7ngG0GGikTzoc/LSYJ6AM
	WagZfhqF+3vhIvCd/d3qzGVb87Qd2Vx75lVULY2Uog==
X-Google-Smtp-Source: ABdhPJw4qrnS+JVSq3hVhm/S1Jy5YBAyn1Y+JpVWvmDirB7KTpYDgjyYVq8lHHJ3/fHmFPJSuEmf5s72xt5cfkv/IQo=
X-Received: by 2002:a17:906:14c9:: with SMTP id y9mr4802942ejc.523.1601067707943;
 Fri, 25 Sep 2020 14:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
 <8370d493-e38d-cbac-1233-14cbbef63936@oracle.com>
In-Reply-To: <8370d493-e38d-cbac-1233-14cbbef63936@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 25 Sep 2020 14:01:36 -0700
Message-ID: <CAPcyv4je4PzCRo=Na7WfCpnvS0VpBN8qArr5HZv7jhwTNui4eg@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] device-dax: support sub-dividing soft-reserved ranges
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: FVKWFJXMUMNNCDA3OA32UNK3RTRHMNDT
X-Message-ID-Hash: FVKWFJXMUMNNCDA3OA32UNK3RTRHMNDT
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Hulk Robot <hulkci@huawei.com>, Ben Skeggs <bskeggs@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jia He <justin.he@arm.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jason Yan <yanaijie@huawei.com>, Paul Mackerras <paulus@ozlabs.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brice Goglin <Brice.Goglin@inria.fr>, Stefano Stabellini <sstabellini@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel@ffwll.ch>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FVKWFJXMUMNNCDA3OA32UNK3RTRHMNDT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 25, 2020 at 1:52 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> Hey Dan,
>
> On 9/25/20 8:11 PM, Dan Williams wrote:
> > Changes since v4 [1]:
> > - Rebased on
> >   device-dax-move-instance-creation-parameters-to-struct-dev_dax_data.patch
> >   in -mm [2]. I.e. patches that did not need fixups from v4 are not
> >   included.
> >
> > - Folded all fixes
> >
>
> Hmm, perhaps you missed the fixups before the above mentioned patch?
>
> From:
>
>         https://www.ozlabs.org/~akpm/mmots/series
>
> under "mm/dax", I am listing those fixups here:
>
> x86-numa-add-nohmat-option-fix.patch
> acpi-hmat-refactor-hmat_register_target_device-to-hmem_register_device-fix.patch
> mm-memory_hotplug-introduce-default-phys_to_target_node-implementation-fix.patch
> acpi-hmat-attach-a-device-for-each-soft-reserved-range-fix.patch
>
> (in https://www.ozlabs.org/~akpm/mmots/broken-out/)

I left those for Andrew to handle. I actually should have started this
set one more down in his stack because that's where my new changes
start.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
