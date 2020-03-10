Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C460180C0E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Mar 2020 00:10:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9D8EE10FC3628;
	Tue, 10 Mar 2020 16:11:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=guoqing.jiang@cloud.ionos.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8142A10FC3624
	for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 16:10:58 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b23so514717edx.4
        for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 16:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZjzfLVKcrEVYs6WhxkjJMrt4JgyDW89UP2lOPu52OFg=;
        b=AFnM8/qVZ5INpBhagP0TzCOiNgkxgenab2JvoMJ9TochGwwsyROWvjIewmaXHDUmar
         l+T11XTf3Z5/Ln3tLw8rQzmHYyAEoebfFfwlJsw4tdw5dINkokIRH6NS2P54C8D6wCSe
         ws5FELqRVVqhVPNU17Zok/L7q8FpBv0xeV2Yx/a7IwZ+YYOXOhMa8eTAabzdA20EG7IY
         J84WyBNSEyA/7FhPiNt9Zcn8JPOOzmRwoHz4R7hn1NRoq0KTMVjRHrmh0e6pxHuZgivu
         ZZqYfgk18R1hF/eFxnc6c5j6COc0wlMKtMCm0st1cu2neOcTZro4+BlqXr2NtmU9v/Vs
         2n4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZjzfLVKcrEVYs6WhxkjJMrt4JgyDW89UP2lOPu52OFg=;
        b=NAlGVR7Fl0loNap6LJAenSFqr/a1zuteU7CF/eJn5nKTJQerAvjJRB7L18UoAYHCAC
         +/jr7anYaBbh0m/62x3lgZBTFj8fK9Nc1zxtN7JyJn14+IR50bcrksu1d0g3J1KDOu29
         R8Falq4wDXLZX663MUP09Gnh+8HwGlHslMcGncyCGKyCiR0K2Id9ca225XR/jSSpK15H
         5J4Cgkag4kO8h1IpCHvobusMKxiBtC9l0rdmZVBP55JaB+JgpyNJiVmT32NmYZdi9S0y
         tZAAz/2t5UoCuhXHq5GpG3QS2RKo4SMuKi5wYbVlGDOVCsRauZQ6IS5CMF4K3HlLWYVg
         Z+gw==
X-Gm-Message-State: ANhLgQ2D4XU5jqUQqSrb/IQ2GllP1VQRqVef1JrzQG4W4u/VVLNe4rka
	1OxqWTwmmq9EHe9QBQvESkRK8A==
X-Google-Smtp-Source: ADFU+vuw/QrLgknOBSnLL6UEPd5ZmG0mMBAvF0lDukG/ngJ9XGt+BMvhR1Vfo0DVxEJ2jx46GiOIfQ==
X-Received: by 2002:a05:6402:549:: with SMTP id i9mr174325edx.323.1583881805877;
        Tue, 10 Mar 2020 16:10:05 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4849:2c00:55b0:6e1e:26ab:27a5? ([2001:16b8:4849:2c00:55b0:6e1e:26ab:27a5])
        by smtp.gmail.com with ESMTPSA id h22sm3715651eds.88.2020.03.10.16.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 16:10:05 -0700 (PDT)
Subject: Re: [PATCH v2] block: refactor duplicated macros
To: Matteo Croce <mcroce@redhat.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-scsi@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20200310223516.102758-1-mcroce@redhat.com>
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <d473061b-688f-f4a6-c0e8-61c22b8a2b10@cloud.ionos.com>
Date: Wed, 11 Mar 2020 00:10:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310223516.102758-1-mcroce@redhat.com>
Content-Language: en-US
Message-ID-Hash: K7FWVCGJHFO5EW5MRF2G5CNFUVUY7JAU
X-Message-ID-Hash: K7FWVCGJHFO5EW5MRF2G5CNFUVUY7JAU
X-MailFrom: guoqing.jiang@cloud.ionos.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jens Axboe <axboe@kernel.dk>, "James E.J. Bottomley" <jejb@linux.ibm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Anna Schumaker <anna.schumaker@netapp.com>, Song Liu <song@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K7FWVCGJHFO5EW5MRF2G5CNFUVUY7JAU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit



On 3/10/20 11:35 PM, Matteo Croce wrote:
> +++ b/drivers/md/raid1.c
> @@ -2129,7 +2129,7 @@ static void process_checks(struct r1bio *r1_bio)
>   	int vcnt;
>   
>   	/* Fix variable parts of all bios */
> -	vcnt = (r1_bio->sectors + PAGE_SIZE / 512 - 1) >> (PAGE_SHIFT - 9);
> +	vcnt = (r1_bio->sectors + PAGE_SECTORS - 1) >> (PAGE_SHIFT - 9);

Maybe replace "PAGE_SHIFT - 9" with "PAGE_SECTORS_SHIFT" too.

Thanks,
Guoqing
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
