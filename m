Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FF5DD0D9
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 23:06:16 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4E22C10FCB925;
	Fri, 18 Oct 2019 14:08:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D989D10FCB902
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 14:08:17 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3112B2B87;
	Fri, 18 Oct 2019 21:06:12 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C4F00100194E;
	Fri, 18 Oct 2019 21:06:11 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [ndctl patch 3/4] query_fw_finish_status: get rid of redundant variable
References: <20191018202302.8122-1-jmoyer@redhat.com>
	<20191018202302.8122-4-jmoyer@redhat.com>
	<20191018205424.GA12760@iweiny-DESK2.sc.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Fri, 18 Oct 2019 17:06:10 -0400
In-Reply-To: <20191018205424.GA12760@iweiny-DESK2.sc.intel.com> (Ira Weiny's
	message of "Fri, 18 Oct 2019 13:54:25 -0700")
Message-ID: <x49sgnp7ohp.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Fri, 18 Oct 2019 21:06:12 +0000 (UTC)
Message-ID-Hash: 6ZTK3T6RQYWZLHKVEBM4UJNTIBYCY7WG
X-Message-ID-Hash: 6ZTK3T6RQYWZLHKVEBM4UJNTIBYCY7WG
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6ZTK3T6RQYWZLHKVEBM4UJNTIBYCY7WG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ira Weiny <ira.weiny@intel.com> writes:

> On Fri, Oct 18, 2019 at 04:23:01PM -0400, Jeff Moyer wrote:
>> The 'done' variable only adds confusion.
>> 
>> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
>> ---
>>  ndctl/dimm.c | 7 +------
>>  1 file changed, 1 insertion(+), 6 deletions(-)
>> 
>> diff --git a/ndctl/dimm.c b/ndctl/dimm.c
>> index c8821d6..f28b9c1 100644
>> --- a/ndctl/dimm.c
>> +++ b/ndctl/dimm.c
>> @@ -682,7 +682,6 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
>>  	struct ndctl_cmd *cmd;
>>  	int rc;
>>  	enum ND_FW_STATUS status;
>> -	bool done = false;
>>  	struct timespec now, before, after;
>>  	uint64_t ver;
>>  
>> @@ -716,7 +715,6 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
>>  					ndctl_dimm_get_devname(dimm));
>>  			printf("Firmware version %#lx.\n", ver);
>>  			printf("Cold reboot to activate.\n");
>> -			done = true;
>>  			rc = 0;
>
> Do we need "goto out" here?

Yes, I missed that one.  Thanks.

>>  			break;
>>  		case FW_EBUSY:
>> @@ -753,7 +751,6 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
>>  				ndctl_dimm_get_devname(dimm));
>>  		case FW_EINVAL_CTX:
>>  		case FW_ESEQUENCE:
>> -			done = true;
>>  			rc = -ENXIO;
>>  			goto out;
>>  		case FW_ENORES:
>> @@ -761,17 +758,15 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
>>  				"Firmware update sequence timed out: %s\n",
>>  				ndctl_dimm_get_devname(dimm));
>>  			rc = -ETIMEDOUT;
>> -			done = true;
>>  			goto out;
>>  		default:
>>  			fprintf(stderr,
>>  				"Unknown update status: %#x on DIMM %s\n",
>>  				status, ndctl_dimm_get_devname(dimm));
>>  			rc = -EINVAL;
>> -			done = true;
>>  			goto out;
>>  		}
>> -	} while (!done);
>> +	} while (true);
>
> I'm not a fan of "while (true)".  But I'm not the maintainer.  The Logic seems
> fine otherwise.

The way things stand today is a mashup of goto vs. break.  I'll
follow-up with fixed up patch next week if there is consensus on the
change.  If you have a suggestion for a better way, that's welcome as
well.

Thanks for looking, Ira!

-Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
